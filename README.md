
# Shadowsocks-libev with Simple-OBFS Docker Image

This Docker image provides a Shadowsocks-libev server with Simple-OBFS obfuscation for enhanced security and circumvention. It's built on a minimal Ubuntu base and optimized for size and performance. The image automatically generates a random password and displays a QR code for easy client setup.

## Features

* **Shadowsocks-libev:** Uses the latest stable version of Shadowsocks-libev for efficient and reliable proxying.
* **Simple-OBFS:** Integrates Simple-OBFS to obfuscate traffic, making it appear like regular TLS traffic, helping bypass censorship.
* **Automatic Configuration:** Generates a random password and configures the server automatically.
* **QR Code Generation:** Displays a QR code for easy client configuration.
* **Customizable Settings:** Allows customization of port, method, and password through environment variables.
* **Minimal Base Image:** Built on a minimal Ubuntu base for reduced image size and improved security.
* **User `nobody`:** Runs the `ss-server` process as the unprivileged user `nobody` for enhanced security.

## Usage


### Building the Docker Image

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/mikhailde/shadowsocks-obfs
   cd shadowsocks-obfs
   ```

2. **Build the Image:**
   ```bash
   docker build -t shadowsocks-obfs:latest .
   ```
   This command builds the image and tags it as `shadowsocks-obfs:latest`. You can use a different tag if you prefer.

### Running the Docker Container

Once the image is built, you can run the container:

```bash
docker run -d -p 8388:8388/tcp -p 8388:8388/udp \
    -e PASSWORD="your_custom_password" \ # Optional: Set your own password
    -e PORT="your_custom_port" \        # Optional: Set a custom port
    -e METHOD="your_custom_method" \    # Optional: Set a custom encryption method
    shadowsocks-obfs:latest
```

* **`-d`**: Runs the container in detached mode (background).
* **`-p 8388:8388/tcp -p 8388:8388/udp`**: Maps host port 8388 to the container's port 8388 for both TCP and UDP traffic. Change `8388` to your desired port if necessary.
* **`-e PASSWORD="your_custom_password"`**: (Optional) Sets the password for the Shadowsocks server. If omitted, a random password will be generated.
* **`-e PORT="your_custom_port"`**: (Optional) Sets the port for the Shadowsocks server. Defaults to 8388.
* **`-e METHOD="your_custom_method"`**: (Optional) Sets the encryption method. Defaults to `chacha20-ietf-poly1305`. See the Shadowsocks-libev documentation for supported methods.


## Security Considerations

While this setup provides a good level of security, consider the following:

* **Regular Updates:** Keep the Docker image updated to benefit from the latest security patches. Rebuild the image periodically to incorporate upstream updates.
* **Firewall:** Configure your firewall to only allow necessary traffic to the Shadowsocks port.
* **Strong Password:** Use a strong and unique password if setting it manually.


## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have any suggestions or improvements.
