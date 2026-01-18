# Tracking Knitting Projects

iOS application for creating and managing projects.

The app allows users to create new projects with a name, image, and description.  
It focuses on clean architecture, UIKit-based UI, and MVP pattern.

---

## 📱 Features

- Create a new project with name and image
- Add project description
- Image picker integration
- Input validation with user-friendly alerts
- Modular MVP architecture
- Navigation handled via Router

## 🧱 Architecture

The app is built using MVP architecture:

- **View** — responsible only for UI and user interactions
- **Presenter** — contains business logic and input validation
- **Router** — handles navigation and external flows
- **Model** — project data model

This separation improves testability, readability, and scalability.

## 🛠 Tech Stack

- **Swift**
- **UIKit**
- **Auto Layout (programmatic)**
- **MVP architecture**
- **CoreData**
