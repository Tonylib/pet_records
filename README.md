# pet_records

This repository contains a prototype Flutter application designed to help Veternarians view and track patients and their medical test results in an intuitive and user-friendly way. The app provides a clear visualization of test history, trends, and current health status, making it easier for Veternarians to stay updated on their patients' health and test results.

What makes this codebase unique is its commitment to self-documenting code principles. Every piece of code is written with clarity and readability in mind, making it accessible not only to developers but also to non-technical stakeholders. The codebase serves as an example of how technical implementations can be structured and named in a way that tells a story, making the business logic and user workflows immediately apparent to anyone reading the code. From descriptive widget names like `TestResultCard` and `GreetingWidget` to well-organized feature modules, the code structure itself acts as living documentation of the application's functionality.

Code Structure:

- `lib/main.dart`: The entry point for the application.
- `lib/pet_records_app.dart`: The widget for the application.
- `lib/core`: Core functionality such as theme, constants, and utility functions.
- `lib/features`: Feature-specific code including widgets, pages, and controllers.

lib/main.dart is the entry point for the application. It uses the `PetRecordsApp` widget to start the application.
lib/pet_records_app.dart contains the widget `PetRecordsApp` that sets up the app's theme, routing, and other configurations.

Walkthrough:
Start the application to see the Greeting.

When the 'Continue' button is clicked, the user is navigated to the `TestResultsPage` page. This page displays a list of test results for the patients of the Veternarian.
 - No endpoint is called, instead the data is featched from a hardcoded data structure in the PetRecordsRepository.
 - A delay is added to the data fetching to simulate a network request.

There is a row of filters above the list of test results. These filters allow the user to filter the test results by status.

Each test result is displayed in a `TestResultCard` widget. This widget displays the test name, value, unit, and status.

If historical data is available, the `TestResultCard` widget will display a chart of the test results when tapped.

# Testing

The application includes a comprehensive test suite that covers both the data and presentation layers. The tests are organized to mirror the application's structure, making them easy to locate and maintain. Key test coverage includes:

- **Repository Tests** (`test/features/home/data/repositories/pet_records_repository_test.dart`): Verify the correct handling of test result data, including fetching and filtering operations.
- **Controller Tests** (`test/features/home/presentation/controllers/test_results_controller_test.dart`): Ensure proper state management and business logic in the presentation layer, including filter operations and data transformations.

Run the tests using the command `flutter test`. The test suite currently includes 17 tests that verify core functionality, data handling, and user interactions. All tests are designed to be readable and maintainable, following the same self-documenting principles as the main codebase.























