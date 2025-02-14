# Jenkins Master-Slave (Controller-Agent) Architecture Setup

The Jenkins Master-Slave (or Controller-Agent) architecture allows you to distribute the workload of building, testing, and deploying applications across multiple machines. This architecture enhances performance and provides better resource utilization, especially in large-scale environments. Here's a detailed guide to setting up Jenkins in this architecture.

## Prerequisites

*   **Jenkins Master:** The main Jenkins server, also known as the controller, which orchestrates the build tasks and distributes them to the agent nodes.
*   **Jenkins Agents:** Additional servers (slaves) that execute the build tasks assigned by the Jenkins master.

## Step 6.1: Setting Up Jenkins Master

You’ve already set up Jenkins on an EC2 instance in the previous steps. This instance will serve as your Jenkins master. Ensure the following are in place:

*   **Java Installation:** Jenkins requires Java to run. Verify that Java is installed:

    ```bash
    java -version
    ```

    If not installed, you can do so with:

    ```bash
    sudo yum install -y java-1.8.0-openjdk
    ```

*   **Jenkins Installation:** Jenkins should be running and accessible via a web browser. Confirm by navigating to `http://<Jenkins_Master_IP>:8080` in your browser.

## Step 6.2: Preparing Jenkins Agent Nodes

You need additional EC2 instances that will act as Jenkins agents. Here's how to set them up:

*   **Launch EC2 Instances for Jenkins Agents:**
    *   Use the AWS Management Console to launch new EC2 instances. You can select an Amazon Linux 2 AMI (or any other Linux distribution).
    *   Ensure these instances have sufficient resources (e.g., t2.medium) and are in the same VPC as the Jenkins master.
*   **Security Groups:**
    *   Ensure the security groups allow SSH access from the Jenkins master.
    *   Allow communication on ports required for Jenkins agent-master communication (default SSH port 22).
*   **Install Java on Agent Nodes:**
    *   SSH into each agent node and install Java:
        ```bash
        sudo yum update -y
        sudo yum install -y java-1.8.0-openjdk
        ```
*   **Create Jenkins User on Agent Nodes:**
    *   Create a user dedicated to running Jenkins on the agent nodes:
        ```bash
        sudo useradd jenkins
        ```
    *   Set up SSH access for this user so the Jenkins master can connect:
        ```bash
        sudo mkdir /home/jenkins/.ssh
        sudo chown jenkins:jenkins /home/jenkins/.ssh
        sudo chmod 700 /home/jenkins/.ssh
        ```
    *   Copy the SSH public key from the Jenkins master to each agent's `/home/jenkins/.ssh/authorized_keys` file.
*   **Install Jenkins Agent on Agent Nodes:**
    *   Download the Jenkins agent (also called `slave.jar`) from the Jenkins master. On the Jenkins master:
        ```bash
        wget http://<Jenkins_Master_IP>:8080/jnlpJars/agent.jar
        ```
    *   Transfer this `agent.jar` file to each agent node, placing it in a directory like `/home/jenkins`.

## Step 6.3: Configuring Jenkins Master to Use Agents

*   **Add New Nodes in Jenkins:**
    *   On the Jenkins dashboard, go to `Manage Jenkins > Manage Nodes and Clouds > New Node`.
    *   Enter a name for the new node (e.g., `Agent-1`), select `Permanent Agent`, and click `OK`.
*   **Configure Node Settings:**
    *   **Remote root directory:** Specify the directory on the agent where Jenkins should operate, e.g., `/home/jenkins`.
    *   **Labels:** Assign labels to the node for easy job allocation (e.g., `linux-agent`).
    *   **Launch method:** Choose `Launch agents via SSH`.
    *   **Host:** Enter the private IP address of the agent node.
    *   **Credentials:** Add SSH credentials (username and private key) for the `jenkins` user.
*   **Test the Connection:**
    *   Click on `Save` and then `Launch agent via SSH`.
    *   Jenkins will attempt to connect to the agent node via SSH. If successful, you will see the agent status change to "Connected".
*   **Repeat for Additional Agents:**
    *   Repeat the above steps to configure any additional Jenkins agent nodes.

## Step 6.4: Configuring Jenkins Jobs to Use Specific Agents

Now that your Jenkins master is connected to agent nodes, you can configure jobs to run on specific agents:

*   **Create or Configure a Jenkins Job:**
    *   Go to `New Item` on the Jenkins dashboard or select an existing job.
*   **Specify Node Usage:**
    *   Under the job configuration, look for the section `Restrict where this project can be run`.
    *   Enter the label of the agent (e.g., `linux-agent`) where you want the job to run.
*   **Save and Build:**
    *   Save the job configuration and trigger a build.
    *   The job should now execute on the specified Jenkins agent node.

## Step 6.5: Monitoring and Managing Jenkins Agents

*   **Node Monitoring:**
    *   Jenkins provides built-in monitoring for each agent node. You can view this by navigating to `Manage Jenkins > Manage Nodes and Clouds`, where you’ll see the status, idle time, and load for each agent.
*   **Scaling Agents:**
    *   For large-scale environments, you may configure auto-scaling for your agent nodes using AWS Auto Scaling Groups, allowing Jenkins to automatically scale the number of agents based on workload.
*   **Agent Availability:**
    *   Ensure agents are always available by configuring them with robust health checks, such as CPU, memory, and disk usage monitoring. Integration with monitoring tools like CloudWatch or Prometheus can help automate this.
