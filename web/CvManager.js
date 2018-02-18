// Requires jquery.js

class CvManager {
    constructor() {
        this.availableLanguages = ["Fr", "En"];
        this.labels = {
            Fr: {
                skillTitle:"Comp&eacute;tences",
                research:"Recherche",
                computerScience:"Informatique",
                teaching:"Enseignement",
                other:"Autres",
                printPage:"Imprimer",
                download:"T&eacute;l&eacute;charger la source (Gem Ruby)",
                loading:"Chargement...",
                updated:"Mis &agrave; jour",
            },
            En: {
                skillTitle:"Skills",
                research:"Research",
                computerScience:"Computer Science",
                teaching:"Teaching",
                other:"Other",
                printPage:"Print",
                download:"Download source (Ruby Gem)",
                loading:"Loading...",
                updated:"Updated",
            },
        };

        this._classesState = { research:false, computerScience:false, teaching:false, other:false };
        this._currentLanguage = this.availableLanguages[0];
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
        $("#cv").load(this.createUrl(),function() { this.onLoadingFinished(); });
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
