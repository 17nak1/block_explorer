# NEAR Block Explorer

A simple block explorer web app for a simulated NEAR blockchain. It fetches recent transactions from a mock NEAR API, stores them in a database, and displays transfer-related actions on the home page.

## 🔍 Features

- Fetches and displays transactions from a simulated NEAR blockchain endpoint.
- Persists historical transactions even if they disappear from the API.
- Displays only **transfer** actions with sender, receiver, and deposit information.
- Uses secure API key storage via `credentials.yml.enc`.

## 🧱 Database Schema

This application utilizes two primary tables to manage transaction data: `transactions` and `actions`.

### `transactions` Table

* **Purpose:** Stores core transaction information.
* **Columns:**
    * `hash` (PRIMARY KEY): Unique identifier for each transaction.
    * `block_hash`: Unique identifier of the block containing the transaction.
    * `height`: Block number that the transaction was included in, representing the sequential order of blocks.
    * `gas_burnt`: Amount of gas consumed by the transaction.
    * **... (Other columns exist but are not listed here)**
* **Note:** Transaction-specific actions are stored separately in the `actions` table due to the one-to-many relationship.

### `actions` Table

* **Purpose:** Stores individual actions associated with transactions.
* **Columns:**
    * `transaction_id` (FOREIGN KEY referencing `transactions.hash`): Links each action to its corresponding transaction.
    * `action_type`: Specifies the type of action performed (e.g., `transfer`, `addKey`, `functionCall`).
    * `data`: Stores the complete action details in TEXT format, providing flexibility for future action types.
* **Relationship:** A one-to-many relationship exists between `transactions` and `actions` (one transaction can have multiple associated actions).

> ℹ️ `data` allows flexibility for new or unknown action types in the future. This is useful given the variety of possible NEAR actions.


## 🚀 Getting Started

### Prerequisites

- Ruby `3.x`
- Rails `7.x`
- Node.js `20.x`
- SQLite

### Installation

1.  Clone the Git repository.
2.  Navigate to the project directory in your terminal.
3.  Install the required gems:

    ```bash
    bundle install
    ```

4.  Create and migrate the database:

    ```bash
    rails db:create db:migrate
    ```

---

## ▶️ Start the App

```bash
rails server
```

Then open your browser and navigate to [http://localhost:3000](http://localhost:3000)

---

## 🧪 Usage

- The root page displays a table of historical **transfer** transactions.
- Even if the API stops returning older transactions, previously saved ones remain visible.
- A button in the UI allows you to fetch and save the most recent transactions again.

---

## 📁 Project Structure (Highlights)

- `app/services/near_api_service.rb`: Handles API calls and data storing from the NEAR API.
- `app/controllers/transactions_controller.rb`: Manages fetching data via `NearApiService` and redirects to the root path on success.
- `app/views/transactions/index.html.erb`: Renders the main UI, displaying a list of transfer actions.
- `app/views/transactions/transactions.css`: Contains CSS styles for formatting the transactions table.
- `app/models/transaction.rb` and `app/models/action.rb`: Defines the models for storing transaction and action data.
- `config/initializers/near_api_service.rb`: Configures and initializes `NearApiService` with the API key from Rails credentials.

---

## 🤔 Notes on Design

- `actions.data` is stored as `text` to flexibly support other action types in the future.
- To accommodate transactions with multiple actions, as evidenced by a transaction containing two actions, the app's data model is designed with a one-to-many relationship.

