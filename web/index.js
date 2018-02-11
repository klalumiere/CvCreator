// Requires jquery.js

// $( document ).ready(initialize);

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

    setClassState(key,rhs) {
        var requiresUpdate = this._classesState[key] != rhs; // TODO: use this variable
        this._classesState[key] = rhs;
    }
    setCurrentLanguage(rhs) {
        var requiresUpdate = this._currentLanguage != rhs; // TODO: use this variable
        this._currentLanguage = rhs;
    }
}

function initialize() {
    // updateCv("");
}

// function updateCv() {
//     window.elementLoading++;
//     if(window.elementLoading==1) $( "#loading" ).show();
//     $('#cv').load(createUrl(),function() {
//         window.elementLoading--;
//         if(window.elementLoading==0) $( "#loading" ).hide();
//         if( !$("#updated").is(":visible") ) $( "#updated" ).fadeIn().delay(1000).fadeOut();
//     });
// }
// function updateLabels(language)
// {
//         document.getElementById('skillTitle').innerHTML=label[1];
//         $('#skillTitle').innerHTML=label[1];
//     ...
// }
// function updateLanguage(language) {
//     updateLabels(language);
//     updateCv("");
// }
