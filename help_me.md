# Run the project

To run the project locally 

-Install git
https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

-Install Flutter
https://flutter.dev/docs/get-started/install

-Clone the git repository (open new terminal)
git clone https://github.com/mtambucho/pokeapp.git
cd pokeapp

-Download the resources 
flutter pub get

-Run (first, make sure you have a emulator or physical device connected
      you can check it with the command 'flutter devices')
flutter run 


# External libraries 
flutter_bloc
   A powerful library for state management, is scalable and highly testable.

equatable
  Used for compare objects in dart without overriding the == operator

http
  Used for call the api
  
shared_preferences
  Used to store simple user data, it is used to know if the onboarding was shown and if the user has an active session

pedantic
  Used to help with best practices for the code. 

flutter_launcher_icons
  Simplifies the task of updating your Flutter app's launcher icon