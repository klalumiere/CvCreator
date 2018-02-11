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

        this._currentLanguage = this.availableLanguages[0];
        this._elementsLoadingCount = 0;
        this._classesState = { research:false, computerScience:false, teaching:false, other:false };

        $("#updated").hide();
        $("#loading").hide();
    }
}

function initialize() {
    // updateCv("");
}
// function updateCv(caller)
// {
//     if(caller!="")
//         window.state[caller]=!window.state[caller]

//     window.elementLoading++;
//     if(window.elementLoading==1)
//         $( "#loading" ).show();
//     $('#cv').load(buildCvUrl(),function() {
//         window.elementLoading--;
//         if(window.elementLoading==0)
//             $( "#loading" ).hide();
//         if( !$("#updated").is(":visible") )
//             $( "#updated" ).fadeIn().delay(1000).fadeOut();
//     });
// }
// function buildCvUrl()
// {
//     var result="cvMaker/"
//     for (var key in window.language) {
//             if(window.language[key])
//                 result+=key;
//     }
//     for (var key in window.state) {
//             if(window.state[key])
//                 result+="&"+key;
//     }
//     return result;
// }

// function switchLanguage(caller)
// {
//     switchLabel(caller);
//     if(window.language[caller])
//         return;
    
//     for (var key in window.language)
//         window.language[key]=false
//     window.language[caller]=true
//     updateCv("");
// }
// function switchLabel(language)
// {
    
//     label=labelFr;
//     if(language=="En")
//         label=labelEn

    //     document.getElementById('skillTitle').innerHTML=label[1];
    //     $('#skillTitle').innerHTML=label[1];
// }
