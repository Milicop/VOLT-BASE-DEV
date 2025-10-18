#!/usr/bin/env python3
import npyscreen
import time

class WelcomeForm(npyscreen.ActionForm):
    def create(self):
        self.add(npyscreen.FixedText, value="Welcome to MyLinux Installer", editable=False)
        self.add(npyscreen.FixedText, value="", editable=False)
        self.add(npyscreen.FixedText, value="This installer will guide you through the installation process.", editable=False)
        self.add(npyscreen.FixedText, value="Press OK to continue or Cancel to exit.", editable=False)
    
    def on_ok(self):
        self.parentApp.setNextForm("SYSTEM")
    
    def on_cancel(self):
        self.parentApp.setNextForm(None)

class SystemConfigForm(npyscreen.ActionForm):
    def create(self):
        self.add(npyscreen.TitleText, name="Hostname:", value="mylinux")
        self.add(npyscreen.TitleText, name="Username:", value="")
        self.add(npyscreen.TitlePassword, name="Password:", value="")
        self.add(npyscreen.TitlePassword, name="Confirm Password:", value="")
        self.add(npyscreen.TitleSelectOne, name="Timezone:", 
                 values=["UTC", "America/New_York", "Europe/London", "Asia/Tokyo"], 
                 max_height=5, scroll_exit=True)
    
    def on_ok(self):
        # Store values in parent app
        self.parentApp.hostname = self.get_widget(0).value
        self.parentApp.username = self.get_widget(1).value
        self.parentApp.password = self.get_widget(2).value
        self.parentApp.setNextForm("DISK")
    
    def on_cancel(self):
        self.parentApp.setNextForm("WELCOME")

class DiskSelectionForm(npyscreen.ActionForm):
    def create(self):
        self.add(npyscreen.FixedText, value="Select installation disk:", editable=False)
        self.add(npyscreen.FixedText, value="WARNING: All data will be erased!", editable=False, color="DANGER")
        self.add(npyscreen.FixedText, value="", editable=False)
        self.disk = self.add(npyscreen.TitleSelectOne, name="Disk:", 
                            values=["/dev/sda (500GB)", "/dev/sdb (1TB)", "/dev/nvme0n1 (256GB)"],
                            max_height=5, scroll_exit=True)
        self.add(npyscreen.FixedText, value="", editable=False)
        self.partition = self.add(npyscreen.TitleSelectOne, name="Partitioning:", 
                                  values=["Automatic (recommended)", "Manual"], 
                                  max_height=3, scroll_exit=True)
    
    def on_ok(self):
        self.parentApp.disk = self.disk.get_selected_objects()[0] if self.disk.value else "None"
        self.parentApp.setNextForm("PACKAGES")
    
    def on_cancel(self):
        self.parentApp.setNextForm("SYSTEM")

class PackageSelectionForm(npyscreen.ActionForm):
    def create(self):
        self.add(npyscreen.FixedText, value="Select software to install:", editable=False)
        self.add(npyscreen.FixedText, value="", editable=False)
        self.packages = self.add(npyscreen.TitleMultiSelect, name="Packages:",
                                values=["Desktop Environment (GNOME)", 
                                       "Desktop Environment (KDE)",
                                       "Web Browser (Firefox)",
                                       "Development Tools",
                                       "Office Suite",
                                       "Media Players"],
                                max_height=8, scroll_exit=True)
    
    def on_ok(self):
        self.parentApp.packages = self.packages.get_selected_objects()
        self.parentApp.setNextForm("CONFIRM")
    
    def on_cancel(self):
        self.parentApp.setNextForm("DISK")

class ConfirmForm(npyscreen.ActionForm):
    def create(self):
        self.add(npyscreen.FixedText, value="Installation Summary", editable=False)
        self.add(npyscreen.FixedText, value="=" * 40, editable=False)
        self.hostname_display = self.add(npyscreen.FixedText, editable=False)
        self.username_display = self.add(npyscreen.FixedText, editable=False)
        self.disk_display = self.add(npyscreen.FixedText, editable=False)
        self.packages_display = self.add(npyscreen.FixedText, editable=False)
        self.add(npyscreen.FixedText, value="", editable=False)
        self.add(npyscreen.FixedText, value="Press OK to begin installation or Cancel to go back.", editable=False)
    
    def beforeEditing(self):
        self.hostname_display.value = f"Hostname: {self.parentApp.hostname}"
        self.username_display.value = f"Username: {self.parentApp.username}"
        self.disk_display.value = f"Disk: {self.parentApp.disk}"
        pkg_count = len(self.parentApp.packages)
        self.packages_display.value = f"Packages: {pkg_count} selected"
    
    def on_ok(self):
        self.parentApp.setNextForm("INSTALL")
    
    def on_cancel(self):
        self.parentApp.setNextForm("PACKAGES")

class InstallForm(npyscreen.FormBaseNew):
    def create(self):
        self.add(npyscreen.FixedText, value="Installing MyLinux...", editable=False)
        self.add(npyscreen.FixedText, value="", editable=False)
        self.status = self.add(npyscreen.FixedText, value="Starting...", editable=False)
        self.progress = self.add(npyscreen.TitleSlider, name="Progress:", out_of=100, value=0)
        self.add(npyscreen.FixedText, value="", editable=False)
        self.log = self.add(npyscreen.BoxTitle, name="Log:", max_height=10, editable=False)
    
    def beforeEditing(self):
        self.status.value = "Installing base system..."
        self.log.values = []
        self.display()
        
        # Simulate installation
        steps = [
            ("Partitioning disk...", 20),
            ("Installing base system...", 40),
            ("Installing bootloader...", 60),
            ("Installing packages...", 80),
            ("Configuring system...", 100)
        ]
        
        for step, progress in steps:
            self.status.value = step
            self.log.values.append(f"[OK] {step}")
            self.progress.value = progress
            self.display()
            time.sleep(1)
        
        self.status.value = "Installation complete!"
        self.log.values.append("[OK] Installation finished successfully!")
        self.display()
        time.sleep(2)
        self.parentApp.setNextForm("FINISH")
        self.editing = False

class FinishForm(npyscreen.ActionForm):
    def create(self):
        self.add(npyscreen.FixedText, value="Installation Complete!", editable=False)
        self.add(npyscreen.FixedText, value="", editable=False)
        self.add(npyscreen.FixedText, value="MyLinux has been successfully installed.", editable=False)
        self.add(npyscreen.FixedText, value="Please reboot your system to start using it.", editable=False)
        self.add(npyscreen.FixedText, value="", editable=False)
        self.add(npyscreen.FixedText, value="Press OK to exit the installer.", editable=False)
    
    def on_ok(self):
        self.parentApp.setNextForm(None)
    
    def on_cancel(self):
        self.parentApp.setNextForm(None)

class InstallerApp(npyscreen.NPSAppManaged):
    def onStart(self):
        # Initialize data storage
        self.hostname = ""
        self.username = ""
        self.password = ""
        self.disk = ""
        self.packages = []
        
        # Register forms - MAIN is the default starting form
        self.addForm("MAIN", WelcomeForm, name="MyLinux Installer")
        self.addForm("SYSTEM", SystemConfigForm, name="System Configuration")
        self.addForm("DISK", DiskSelectionForm, name="Disk Selection")
        self.addForm("PACKAGES", PackageSelectionForm, name="Package Selection")
        self.addForm("CONFIRM", ConfirmForm, name="Confirm Installation")
        self.addForm("INSTALL", InstallForm, name="Installing")
        self.addForm("FINISH", FinishForm, name="Installation Complete")

if __name__ == "__main__":
    app = InstallerApp()
    app.run()
