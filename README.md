# Backup Verification Tool

A lightweight bash script for comparing file counts across multiple servers to perform basic backup verification.

![Bash](https://img.shields.io/badge/bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)
![Version](https://img.shields.io/badge/version-1.0-green?style=for-the-badge)

## 📋 Overview

This tool provides a simple method to verify backup completion by counting files on different servers and comparing the results. While not a comprehensive backup verification solution, matching file counts can indicate that backups have been successfully transferred between systems.

## ✨ Features

- 🔄 **Multi-server support** - Compare file counts across unlimited servers
- 🎨 **Colorful output** - Easy-to-read results with color-coded information
- ⏳ **Progress indicators** - Visual feedback during file counting operations
- 🔧 **Easy configuration** - Simple array-based server configuration
- 📊 **Clean reporting** - Formatted output with timestamps
- 🔐 **SSH-based** - Secure connections using existing SSH configurations

## 🚀 Quick Start

### Prerequisites

- Bash shell (version 4.0 or higher)
- SSH client installed
- SSH access configured to target servers (preferably with key-based authentication)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/backup-verification-tool.git
cd backup-verification-tool
```

2. Make the script executable:
```bash
chmod +x verify-backups.sh
```

3. Configure your servers (see Configuration section below)

4. Run the script:
```bash
./verify-backups.sh
```

## ⚙️ Configuration

Edit the `SERVERS` array in the script to include your server details:

```bash
SERVERS=(
    "Production Server|user@prod.example.com|/var/backups/daily"
    "Backup Server 1|user@backup1.example.com|/backup/storage/daily"
    "Backup Server 2|user@backup2.example.com|/mnt/backups/daily"
)
```

**Format:** `"Display Name|SSH User@Host|Path"`

- **Display Name**: Friendly name shown in the output
- **SSH User@Host**: SSH connection string (user@hostname or user@ip)
- **Path**: Absolute path to the directory containing files to count

### SSH Configuration

For best results, configure SSH key-based authentication:

```bash
# Generate SSH key (if you don't have one)
ssh-keygen -t rsa -b 4096

# Copy public key to servers
ssh-copy-id user@server.example.com
```

## 📖 Usage

### Basic Usage

Simply run the script after configuration:

```bash
./verify-backups.sh
```

### Example Output

```
========================================================================================================
                                          BACKUPS COUNT REPORT                                          
========================================================================================================

🖥️  Production Server
   Path: /var/backups/daily
   File count: 1,247

🖥️  Backup Server 1
   Path: /backup/storage/daily
   File count: 1,247

🖥️  Backup Server 2
   Path: /mnt/backups/daily
   File count: 1,243

✅ Report completed at Fri Sep 26 14:30:22 EDT 2025
```

## ⚠️ Limitations

This tool provides basic verification with the following limitations:

- **File count only**: Doesn't verify file integrity, content, or checksums
- **No size verification**: Doesn't compare file sizes or detect corruption
- **No timestamp checks**: Doesn't verify file modification dates
- **Basic error handling**: Limited error reporting for failed connections

### For Critical Backups

Consider implementing additional verification methods:

- **Checksum verification**: Use `rsync --checksum` or similar tools
- **File integrity**: Implement hash-based verification (MD5, SHA256)
- **Content validation**: Test restore procedures regularly
- **Monitoring integration**: Connect with monitoring systems for alerts

## 🛠️ Troubleshooting

### Common Issues

**SSH Connection Failures:**
- Verify SSH access: `ssh user@server.example.com`
- Check SSH key authentication
- Ensure servers are reachable

**Permission Denied:**
- Verify user has read access to specified paths
- Check if paths exist on target servers

**Slow Performance:**
- Large directories may take time to count


## License

[MIT License](LICENSE)

## AI Assistance Disclosure

This tool was developed with assistance from AI language models.

