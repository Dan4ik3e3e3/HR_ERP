# Enterprise Resource Planning (ERP) System

A modern web-based ERP system built with React, Node.js, and MongoDB. This system helps organizations manage their resources, employees, inventory, and finances efficiently.

## Features

- **User Authentication & Authorization**
  - Secure login and registration
  - Role-based access control
  - JWT-based authentication

- **Employee Management**
  - Employee profiles and details
  - Performance tracking
  - Leave management
  - Document management

- **Inventory Management**
  - Stock tracking
  - Purchase orders
  - Supplier management
  - Low stock alerts

- **Finance Management**
  - Revenue tracking
  - Expense management
  - Financial reports
  - Budget planning

- **Dashboard & Analytics**
  - Real-time statistics
  - Interactive charts
  - Performance metrics
  - Activity logs

## Technology Stack

### Frontend
- React.js
- Redux Toolkit (State Management)
- Material-UI (Component Library)
- Chart.js (Data Visualization)
- Formik & Yup (Form Management)
- Axios (API Client)

### Backend
- Node.js
- Express.js
- MongoDB (Database)
- Mongoose (ODM)
- JWT (Authentication)
- bcrypt.js (Password Hashing)

## Getting Started

### Prerequisites
- Node.js (v14 or higher)
- MongoDB
- npm or yarn

### Installation

1. Clone the repository:
\`\`\`bash
git clone https://github.com/yourusername/erp-system.git
cd erp-system
\`\`\`

2. Install backend dependencies:
\`\`\`bash
cd backend
npm install
\`\`\`

3. Install frontend dependencies:
\`\`\`bash
cd ../frontend
npm install
\`\`\`

4. Create a .env file in the backend directory:
\`\`\`
MONGODB_URI=your_mongodb_uri
JWT_SECRET=your_jwt_secret
PORT=5000
\`\`\`

5. Create a .env file in the frontend directory:
\`\`\`
REACT_APP_API_URL=http://localhost:5000/api
\`\`\`

### Running the Application

1. Start the backend server:
\`\`\`bash
cd backend
npm run dev
\`\`\`

2. Start the frontend development server:
\`\`\`bash
cd frontend
npm start
\`\`\`

The application will be available at `http://localhost:3000`

## API Documentation

### Authentication Endpoints
- POST `/api/auth/register` - Register a new user
- POST `/api/auth/login` - Login user
- GET `/api/auth/me` - Get current user

### Employee Endpoints
- GET `/api/employees` - Get all employees
- POST `/api/employees` - Create new employee
- GET `/api/employees/:id` - Get employee by ID
- PUT `/api/employees/:id` - Update employee
- DELETE `/api/employees/:id` - Delete employee

### Inventory Endpoints
- GET `/api/inventory` - Get all inventory items
- POST `/api/inventory` - Add new inventory item
- PUT `/api/inventory/:id` - Update inventory item
- DELETE `/api/inventory/:id` - Delete inventory item

### Finance Endpoints
- GET `/api/finance/transactions` - Get all transactions
- POST `/api/finance/transactions` - Add new transaction
- GET `/api/finance/reports` - Generate financial reports

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

For support, email support@erpsystem.com or open an issue in the repository. 