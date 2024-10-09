## Eclipse
If we don't have JUNIT installed we can navigate to help->install software. This will open a pop-up, select all sources and search for programming languages -> java and pick the java development extensions to install.  

Back in the main editor, we need to add a library to our project. Right click on the project directory and select "add library" then select JUNIT-5. This will add the library and should let us run the tests. On the top bar click the "run" dropdown then select "run as"->"junit test".


## VSCode
Start by opening project folder and installing "Extension Pack for Java". Navigate to the testing page on the left side bar and select "add java tests" then pick "junit jupyter" to select JUNIT-5. This will create a "lib/" folder that contains a JUNIT jar file that is used for testing. Tests can then easily be run in vscode.