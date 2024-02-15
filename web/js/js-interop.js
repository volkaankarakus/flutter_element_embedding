// Sets up a channel to JS-interop with Flutter
(function(){
    "use strict";
    // This function will be called from Flutter when it prepares the JS-interop
    window._stateSet = function (){
        console.log('Hello from Flutter');
    };

    // The state of the Flutter app, see "class _MyAppState" in element_embedding_view.dart.
    let appState = window._appState;

    // Get the input box i.e `value`
    let valueField = document.querySelector("#value");
    let updateState = function() {
        valueField.value = appState.count ; // Function present inside the "element_embedding_view.dart"
    };

    // Register a callback to update the HTML field from Flutter
    appState.addHandler(updateState);

    // Render the first value (0)
    updateState();

    // Get the increment button
    let incrementButton = document.querySelector("#increment");
    incrementButton.addEventListener("click", (event) => {
        appState.increment();
    });
     
}()); 