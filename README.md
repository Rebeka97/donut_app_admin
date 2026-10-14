Welcome to the Donut Delivery Admin Portal repository! This is a dedicated administrative tool built with Flutter, designed to manage the content, menu items, nutritional macros, and database records for the primary donut delivery application ecosystem.

<img width="760" height="1437" alt="image" src="https://github.com/user-attachments/assets/1805f997-e26f-4d26-83a7-e5bbeef8f7c0" />

<h2>Features & Capabilities</h2>
- Menu Item Management: Seamlessly add, update, and manage artisanal donut items (including seasonal specials like the Halloween Series and Christmas Gingerbread Edition).
<br>
- Detailed Content Control: Input and edit engaging marketing descriptions, flavor profiles, and categorizations (e.g., Filled, Chocolate, Seasonal).
<br>
- Nutritional Macro Tracking: Precisely define and upload calorie counts and macronutrient breakdowns (Protein, Carbs, Fat) for every single item.
<br>
- Firebase Cloud Integration: Instantly syncs and writes all menu data, descriptions, and metadata directly to Cloud Firestore.
<br>
- Asset & Image Management: Coordinate item visuals and upload media assets via Firebase Storage.
<br>
- Secure Admin Access: Restricted authentication layer ensuring that only authorized administrators can modify the store catalog.

<h2>Quick Test / Demo Credentials</h2>
To test the application and access the administrative features, you can log in using the following test credentials:
<br>
<br>
<b>Email:</b>admin@gmail.com
<br>
<b>Password:</b>Admin123.
<br>
<br>
(Note: Access is strictly restricted to authorized admin accounts.)

<h2>Tech Stack & Backend</h2>
Framework: Flutter (Dart)
<br>
Backend & Database: Firebase Firestore (Real-time menu database operations)
<br>
Storage: Firebase Storage (Asset management for donut imagery)
<br>
Authentication: Firebase Auth (Admin-level security)

<h2>Getting Started</h2>
Clone the repository:
<br>
&nbsp;&nbsp;Bash
<br>
&nbsp;&nbsp;git clone <repository-url>
<br>
<br>
Navigate to the project directory and install dependencies:
<br>
&nbsp;&nbsp;Bash
<br>
&nbsp;&nbsp;flutter pub get
<br>
<br>
Configure your Firebase project credentials (firebase_options.dart).
<br>
<br>
Run the admin application:
<br>
&nbsp;&nbsp;Bash
<br>
&nbsp;&nbsp;flutter run
<br>
<br>
This application works hand-in-hand with the main consumer-facing Donut Delivery client app, ensuring a dynamic and always up-to-date catalog!
