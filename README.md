# SonarQube Installation GitHub Action

This action automates the installation and setup of SonarQube on a system. It downloads and unzips SonarQube, sets up a user and group for security, starts SonarQube, and configures it to run as a system service. It also enables SonarQube to start automatically at boot, making it easy for users to manage and monitor. This action simplifies the process of installing SonarQube, saving time and effort for users.

## How Easy Is This for a User to Make Use of This Action?

It’s very easy for users to make use of this action. Once the action is added to their GitHub repository, they can simply trigger it in their workflows. Here’s why:

- **No Manual Setup**: The action handles the entire SonarQube installation and setup automatically.
- **Pre-configured Steps**: All the necessary steps, such as downloading, unzipping, configuring, and starting SonarQube, are already defined.
- **Easy to Integrate**: Users can add it to their CI/CD pipeline without needing to manually install or configure SonarQube on their servers.
- **Minimal Configuration**: Users may only need to tweak a few settings (e.g., database configuration) if required, but most of the setup is handled automatically.

In short, users can simply use this action without having to deal with complex setup, making it very user-friendly.

## Example Usage

You can use this action in your GitHub workflows by including it in your `.github/workflows` directory.

### Example Workflow: `sonarqube-install.yml`

```yaml
name: SonarQube Installation

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  install-sonarqube:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Install SonarQube
      uses: ./sonarqube-action@v1
      with:
        sonarqube_version: '9.9.0.65466'  # Optional: specify the SonarQube version

    - name: Start SonarQube Service
      run: |
        sudo systemctl start sonar
        sudo systemctl enable sonar
        sudo systemctl status sonar
