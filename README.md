# Load Balanced Node.js Application with MongoDB Replication

This application demonstrates a production-grade setup with load balancing, MongoDB replication, and secure access through Nginx.

## Architecture Overview

### 1. Nginx Configuration (20 points)


### 2. Load Balancing (20 points)

### 3. Application (20 points)


### 4. MongoDB Setup (10 points)

### 5. MongoDB Volume Management (10 points)
### 6. MongoDB Replication (40 points)


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
- Connection string: `mongodb://my-mongodb.uz:27017/mydatabase?directConnection=true`
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
    { _id: 0, host: "mongodb1:27017", priority: 2 },
    { _id: 1, host: "mongodb2:27017", priority: 1 },
    { _id: 2, host: "mongodb3:27017", priority: 1 }
  ]
})
```

### Monitoring Replication
```bash
# Check replica set status
docker exec mongodb1 mongosh --eval "rs.status()"


```

## Volume Management

### Data Persistence
```yaml
volumes:
  mongodb1_data:
    name: mongodb1_data
  mongodb1_config:
    name: mongodb1_config
  mongodb2_data:
    name: mongodb2_data
  mongodb2_config:
    name: mongodb2_config
  mongodb3_data:
    name: mongodb3_data
  mongodb3_config:
    name: mongodb3_config
  nginx_logs:
    name: nginx_logs
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




## Troubleshooting

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












