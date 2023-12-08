# Custom CDN Implementation with Docker

## Project Overview

This project demonstrates the setup of a custom Content Delivery Network (CDN) using Docker to deliver images across the globe efficiently. The setup includes a BIND DNS server, two HAProxy load balancers, four Nginx nodes, an Ngrok tunnel for external access, and a redirect server.

## Components

- **BIND Server**: Provides DNS services and geo-targeting capabilities.
- **Load Balancers**: Two HAProxy instances implementing round-robin load balancing.
- **Nodes**: Four Nginx web servers (node1, node2, node3, node4) serving images.
- **Ngrok Tunnel**: Exposes local services to the internet.
- **Redirect Server**: An Nginx instance configured to redirect requests to appropriate load balancers based on geographic location.

## Project Structure

```
.
├── docker-compose.yml         # Docker Compose configuration file
├── bind
│   ├── db.localtest.com       # BIND DNS zone file
│   └── named.conf             # BIND DNS configuration file
├── loadbalancer
│   ├── haproxy1.cfg           # Configuration for Load Balancer 1
│   └── haproxy2.cfg           # Configuration for Load Balancer 2
├── ngrok
│   └── ngrok.yml              # Ngrok configuration file
├── node
│   ├── html                   # HTML files for nodes
│   └── images                 # Directory containing images
└── redirect
    └── nginx.conf             # Nginx configuration for the redirect server
```

## Setup and Deployment

1. **Start the Services**:
   ```
   docker-compose up -d
   ```

2. **DNS Resolution**:
   - The BIND server resolves `us.localtest.com` and `de.localtest.com` to appropriate IP addresses.

3. **Load Balancer**:
   - Each load balancer routes traffic to two Nginx nodes in a round-robin fashion.

4. **Accessing the CDN**:
   - Access images via `http://us.localtest.com` or `http://de.localtest.com`.

## Load Balancing Strategies

In this CDN setup, various load balancing strategies can be considered, each with its own advantages and disadvantages. Here's an overview of some common strategies:

### 1. Round-Robin
- **Method**: Distributes requests sequentially among the servers in the pool.
- **Pros**: Simple, ensures equal distribution, no idle servers.
- **Cons**: Ignores server load and capacity, not session-aware.

### 2. Least Connections
- **Method**: Directs traffic to the server with the fewest active connections.
- **Pros**: More responsive to server load, better performance under uneven load.
- **Cons**: More complex, not ideal for long-lasting connections.

### 3. Source IP Hash
- **Method**: Uses a hash of the source IP address to direct traffic, ensuring a user consistently reaches the same server.
- **Pros**: Provides session persistence without server-side storage.
- **Cons**: Redistribution of traffic when server pool changes, not load-aware.

### 4. URL Hash
- **Method**: Uses a hash of the URL to determine the server, ensuring requests for the same URL are directed to the same server.
- **Pros**: Can improve cache efficiency on the server side.
- **Cons**: Uneven load distribution if certain URLs are more popular.

### 5. Weighted Round-Robin
- **Method**: An extension of round-robin where servers are assigned weights based on capacity or performance.
- **Pros**: Accounts for different server capacities, more efficient resource utilization.
- **Cons**: Requires proper weighting, more complex to configure.

### 6. Weighted Least Connections
- **Method**: Similar to least connections but with server weighting.
- **Pros**: Combines server load awareness with capacity considerations.
- **Cons**: Complexity in assigning and managing weights.

### 7. Random
- **Method**: Randomly selects a server for each request.
- **Pros**: Simple, no need for tracking connections or server state.
- **Cons**: Can lead to uneven load distribution, not predictable.
