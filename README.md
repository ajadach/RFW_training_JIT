# Robot Framework - Workshop | Robot Framework – ukryty gral automatyzacji

Dear Participant,

I’m glad you chose my workshop :)

To verify the environment we'll be using during the workshop, please follow the steps outlined in the WORKSHOP INSTRUCTIONS section.

## WORKSHOP INSTRUCTIONS

Please make sure to arrive at the workshop with a **laptop** – preferably running **Windows**.  
Ensure that your laptop is not restricted by any limitations such as:

- lack of administrative privileges (required to install tools),
- restricted internet access (VPN, firewall, proxy, etc.).

---

### Prerequisites

#### Skills:
- Basic understanding of software testing and version control
- GitHub account and basic Git knowledge

#### Technical Prerequisites:

#### 1. Install Python (version 3.10 or higher)  
- Download and install from:  
👉 https://www.python.org/downloads/

#### 2. Install IDE

- VS Code: Download and install from:  
👉 https://code.visualstudio.com/download

- Pycharm:  Download and install from:  
👉 https://www.jetbrains.com/pycharm/download/?section=windows

#### 3. Install Robot Framework

- open **terminal** (Linux) or **CMD** (Windows)
- type: pip install robotframework

After installation, verify the installation:
```bash
pip list
```
You should see list of installed python libraries, on this list you should see robotframework
```bash
...
PyYAML                         6.0.2
regex                          2024.11.6
requests                       2.32.3
robotframework                 7.4
...
```

#### 3. Install Robot Framework Plugin
If you already use Robot Framework, you can stay on your settings

👉 In VC Code
- Go to "Extension" Tab
- Search and install RobotCode - Robot Framework Support

👉 In Pycharm
- Go to Settings Tab -> Plugin
- Search and install RobotCode - Robot Framework Support
- If you do not see this plugin, you can try IntelliBot #patched


### GitHub & Project Setup

#### 4. Fork the Repository  
Go to:  
👉 https://github.com/ajadach/RFW_training_JIT.git

Click **Fork** to create a copy in your GitHub account.

> ℹ️ Don’t have a GitHub account? Create one first at https://github.com

#### 5. Clone Your Forked Repository  
Clone your forked repo to your local machine:
```bash
git clone https://github.com/YOUR_USERNAME/RFW_training_JIT.git
```

#### 6. Open the Project in VS Code  
Navigate to the cloned folder and open it in VS Code.

#### 7. Check if everything works fine
- Open Terminal in VS Code / Pycharm
- Navigate to RFW_training_JIT folder
- execute:
```bash
python -m robot Tests\Test_Setup.robot   
```
You should see the result:
```bash
==============================================================================
Test Setup :: Simple Robot Framework test setup
==============================================================================
Simple Variable Test :: Test basic variable usage                     | PASS |
------------------------------------------------------------------------------
Simple Math Test :: Test basic mathematical operations                | PASS |
------------------------------------------------------------------------------
String Operations Test :: Test string manipulation                    | PASS |
------------------------------------------------------------------------------
List Operations Test :: Test list operations                          | PASS |
------------------------------------------------------------------------------
Test Setup :: Simple Robot Framework test setup                       | PASS |
4 tests, 4 passed, 0 failed
==============================================================================
Output:  C:\workshop\RFW_training_JIT\output.xml
Log:     C:\workshop\RFW_training_JIT\log.html
Report:  C:\workshop\RFW_training_JIT\report.html
PS C:\workshop\RFW_training_JIT> 
```
### ✅ You're All Set!

Make sure everything is installed and working **before the workshop** to ensure smooth participation. In case of any problems with installation or configuration, please don't hesitate to contact me directly: artur.k.ziolkowski@gmail.com

See you soon! :)


