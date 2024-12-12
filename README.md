# Load Balanced Node.js Application with MongoDB Replication

This application demonstrates a production-grade setup with load balancing, MongoDB replication, and secure access through Nginx.

## Architecture Overview

### 1. Nginx Configuration (20 points)
- Reverse proxy for application instances
- Stream configuration for MongoDB access
- SSL/TLS ready configuration
- Custom domain routing

### 2. Load Balancing (20 points)
- Two Node.js application instances
- Round-robin load distribution
- Health checks for high availability
- Zero-downtime deployments

### 3. Application (20 points)
- Node.js Express application
- RESTful API endpoints
- Swagger documentation
- Environment-based configuration

### 4. MongoDB Setup (10 points)
- Secure authentication
- Network isolation
- Optimized configuration
- Data persistence

### 5. MongoDB Volume Management (10 points)
- Persistent data storage
- Separate volumes for data and config
- Backup-ready configuration
- Volume naming strategy

### 6. MongoDB Replication (40 points)
- 3-node replica set
- Automatic failover
- Data redundancy
- Replication monitoring

## Prerequisites

- Docker and Docker Compose
- MongoDB Compass
- Domain setup in hosts file

## Domain Configuration

Add to your hosts file (`/etc/hosts` on Linux/Mac or `C:\Windows\System32\drivers\etc\hosts` on Windows):
```
127.0.0.1 myapp.uz
127.0.0.1 my-mongodb.uz
```

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/golanguzb70/udevslabs-lesson2-app
cd udevslabs-lesson2-app
```

2. Start the services:
```bash
docker-compose up -d
```

3. Verify deployment:
```bash
docker-compose ps
```

## Service Access

### Application
- Main application: http://myapp.uz
- API documentation: http://myapp.uz/api-docs

### MongoDB
- Connection string: `mongodb://admin:password@my-mongodb.uz:27017/?authSource=admin&replicaSet=rs0`
- Replica set members:
  - Primary: mongodb-primary:27017
  - Secondary 1: mongodb-secondary1:27017
  - Secondary 2: mongodb-secondary2:27017

## MongoDB Replication Setup

### Replica Set Configuration
```javascript
rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongodb-primary:27017", priority: 2 },
    { _id: 1, host: "mongodb-secondary1:27017", priority: 1 },
    { _id: 2, host: "mongodb-secondary2:27017", priority: 1 }
  ]
})
```

### Monitoring Replication
```bash
# Check replica set status
docker exec mongodb-primary mongosh --eval "rs.status()"

# Check replication lag
docker exec mongodb-primary mongosh --eval "rs.printSlaveReplicationInfo()"
```

## Volume Management

### Data Persistence
```yaml
volumes:
  mongodb_primary_data:
  mongodb_secondary1_data:
  mongodb_secondary2_data:
  mongodb_config:
  nginx_logs:
```

### Backup and Restore
```bash
# Backup
docker exec mongodb-primary mongodump --out /data/backup

# Restore
docker exec mongodb-primary mongorestore /data/backup
```

## Load Balancing Verification

1. Check load distribution:
```bash
curl -I http://myapp.uz
```

2. Monitor nginx access logs:
```bash
docker-compose logs nginx
```

## Security Features

1. Network Isolation
- Internal Docker network for services
- No exposed ports except through Nginx
- Secure MongoDB access

2. Authentication
- MongoDB authentication enabled
- Secure password storage
- SSL/TLS ready

3. Data Protection
- Persistent volume encryption
- Regular automated backups
- Replica set data redundancy

## Monitoring and Maintenance

### Health Checks
```bash
# Check service health
docker-compose ps

# View service logs
docker-compose logs [service_name]
```

### Scaling
```bash
# Scale application instances
docker-compose up -d --scale app=3
```

### Updates
```bash
# Update services
docker-compose pull
docker-compose up -d
```

## Troubleshooting

1. MongoDB Connectivity
```bash
# Check replica set status
docker exec mongodb-primary mongosh --eval "rs.status()"
```

2. Load Balancer Issues
```bash
# Check nginx configuration
docker exec nginx nginx -t
```

3. Application Problems
```bash
# View application logs
docker-compose logs app1 app2
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.












