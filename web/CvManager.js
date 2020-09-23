// Requires jquery.js

class CvManager {
    constructor({ initialLanguage = 'Fr' } = {})
    {
        this.availableLanguages = ["Fr", "En"];
        this.labels = {
            Fr: {
                computerScience:"Informatique",
                loading:"Chargement...",
                openInLatex:"Ouvrir en LaTeX",
                other:"Autres",
                printPage:"Imprimer",
                research:"Recherche",
                skillTitle:"Comp&eacute;tences",
                teaching:"Enseignement",
                updated:"Mis &agrave; jour",
            },
            En: {
                computerScience:"Computer Science",
                loading:"Loading...",
                openInLatex:"Open in LaTeX",
                other:"Other",
                printPage:"Print",
                research:"Research",
                skillTitle:"Skills",
                teaching:"Teaching",
                updated:"Updated",
            },
        };

        this._classesState = { research:false, computerScience:false, teaching:false, other:false };
        this._currentLanguage = initialLanguage;
        this._elementsLoadingCount = 0;

        $("#updated").hide();
        $("#loading").hide();
        this.updateCv();
    }

    createUrl() {
        var result = "CvCreator/" + this.getCurrentLanguage();
        for (var key in this._classesState) if(this._classesState[key]) result += "__" + key;
        return result;
    }
    createTexUrl() {
        return this.createUrl().replace("CvCreator","CvCreatorTex");
    }
    getAvailableClasses() {
        var result = [];
        for(var key in this._classesState) {
            result.push(key);
        }
        return result;
    }
    getClassState(key) {
        return this._classesState[key];
    }
    getCurrentLanguage() {
        return this._currentLanguage;
    }
    getElementsLoadingCount() {
        return this._elementsLoadingCount;
    }

    setCurrentLanguage(rhs) {
        var requiresUpdate = this._currentLanguage != rhs;
        this._currentLanguage = rhs;
        if(requiresUpdate) this.updateLanguage();
    }
    setElementsLoadingCount(rhs) {
        this._elementsLoadingCount = rhs;
    }
    toggleClassState(key) {
        this._classesState[key] = !this._classesState[key];
        this.updateCv();
    }

    onLoadingFinished() {
        this._elementsLoadingCount--;
        if(this._elementsLoadingCount == 0) $("#loading").hide();
        if( !$("#updated").is(":visible") ) $( "#updated" ).fadeIn().delay(1000).fadeOut();
    }
    updateCv() {
        this._elementsLoadingCount = this._elementsLoadingCount + 1;
        if(this._elementsLoadingCount == 1) $("#loading").show();
        var fixedThis = this;
        $("#cv").load(this.createUrl(),function() { fixedThis.onLoadingFinished(); });
    }
    updateLanguage() {
        this._updateLabels();
        this.updateCv();
    }

    _updateLabels() {
        var currentLabels = this.labels[this._currentLanguage];
        for(var key in currentLabels) $("#" + key).html(currentLabels[key]);
    }
}
