# ZinApp V2 Development Scripts

This directory contains utility scripts for ZinApp V2 development.

## JSON Server Setup

The JSON Server scripts set up a local mock backend for authentication and data storage during MVP development.

### Windows Setup

1. Run `setup_json_server.bat` to install JSON Server and create the initial database
2. Edit the generated `start_json_server.bat` to set your local IP address
3. Run `start_json_server.bat` to start the server

### Unix/Mac Setup

1. Make the script executable: `chmod +x setup_json_server.sh`
2. Run `./setup_json_server.sh` to install JSON Server and create the initial database
3. Start the server with: `json-server --watch data/db.json --host YOUR_LOCAL_IP --port 3000`

### Accessing the Server

Once running, the server provides the following endpoints:

- `http://YOUR_LOCAL_IP:3000/users` - User accounts
- `http://YOUR_LOCAL_IP:3000/stylists` - Stylist accounts
- `http://YOUR_LOCAL_IP:3000/posts` - Social posts
- `http://YOUR_LOCAL_IP:3000/comments` - Post comments
- `http://YOUR_LOCAL_IP:3000/bookings` - Booking records
- `http://YOUR_LOCAL_IP:3000/achievements` - Achievement definitions
- `http://YOUR_LOCAL_IP:3000/badges` - Badge definitions
- `http://YOUR_LOCAL_IP:3000/tokenTransactions` - Token transaction history

### Test Accounts

The initial database includes the following test accounts:

#### Regular User
- Email: test@example.com
- Password: password123
- Username: TestUser

#### Stylist
- Email: stylist@example.com
- Password: password123
- Username: MasterStylist

## Notes

- The JSON Server is for development and testing only, not for production use
- All data is stored in `data/db.json` and can be manually edited if needed
- The server supports standard REST operations (GET, POST, PUT, PATCH, DELETE)
- For more information, see the [JSON Server documentation](https://github.com/typicode/json-server)
