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
    }

    createUrl() {
        var result = "CvCreator/" + this.getCurrentLanguage();
        for (var key in this._classesState) if(this._classesState[key]) result += "&" + key;
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
        if(requiresUpdate) this._updateLanguage();
    }
    toggleClassState(key) {
        this._classesState[key] = !this._classesState[key];
        // this._updateCv();
    }

    // _updateCv() {
    //     this._elementsLoadingCount++;
    //     if(this._elementsLoadingCount == 1) $("#loading").show();
    //     $("#cv").load(createUrl(),function() { this._onLoadingFinished(); });
    // }
    _updateLanguage() {
        this._updateLabels();
        // this._updateCv();
    }

    // _onLoadingFinished() {
    //     this._elementsLoadingCount--;
    //     if(this._elementsLoadingCount == 0) $( "#loading" ).hide();
    //     if( !$("#updated").is(":visible") ) $( "#updated" ).fadeIn().delay(1000).fadeOut();
    // }
    _updateLabels() {
        var currentLabels = this.labels[this._currentLanguage];
        for(var key in currentLabels) $("#" + key).html(currentLabels[key]);
    }
}

// $( document ).ready(initialize);

// function initialize() {
    // window.cvManager = new CvManager;
    // _updateCv(); // The constructor of CvManager should call this
// }
