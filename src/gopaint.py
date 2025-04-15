import sys
import logging
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QLabel, QFileDialog, QVBoxLayout, QWidget, QColorDialog, QMessageBox, QSplashScreen
)
from PyQt5.QtGui import QPixmap, QImage, QPainter, QPen, QColor, QIcon
from PyQt5.QtCore import Qt, QPoint, QTimer
from pyqtribbon import RibbonBar, RibbonStyle

# Configure logging
logging.basicConfig(
    level=logging.INFO,  # Set the logging level to INFO
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.StreamHandler(sys.stdout),  # Output logs to the console
    ],
)

class GoPaint(QMainWindow):
    def __init__(self):
        super().__init__()
        
        # Initialize the image attribute here
        self.image = QImage(800, 600, QImage.Format_RGB32)
        self.image.fill(Qt.white)

        # Initialize other attributes
        self.drawing = False
        self.lastPoint = QPoint()
        self.pen_color = Qt.black
        self.pen_size = 3

        # Initialize the UI
        self.initUI()
        logging.info("GoPaint application initialized.")

    def initUI(self):
        logging.info("Setting up the UI.")
        self.setWindowTitle("GoPaint")
        self.setGeometry(100, 100, 1200, 800)

        # Set the application window icon
        self.setWindowIcon(QIcon("icon.png"))

        # Ribbon Bar
        ribbon = RibbonBar(maxRows=2)
        ribbon.setRibbonStyle(RibbonStyle.Default)
        self.setMenuBar(ribbon)

        # File Category
        fileCategory = ribbon.addCategory("File")
        filePanel = fileCategory.addPanel("File Operations")
        open_button = filePanel.addLargeButton("Open", icon=QIcon("open.png"))
        open_button.clicked.connect(self.openImage)
        save_button = filePanel.addLargeButton("Save", icon=QIcon("save.png"))
        save_button.clicked.connect(self.saveImage)

        # Tools Category
        toolsCategory = ribbon.addCategory("Tools")
        toolsPanel = toolsCategory.addPanel("Drawing Tools")
        bucket_button = toolsPanel.addLargeButton("Bucket Fill", icon=None)
        bucket_button.clicked.connect(self.showBucketError)
        color_button = toolsPanel.addLargeButton("Set Color", icon=QIcon("color.png"))
        color_button.clicked.connect(self.selectColor)

        sizePanel = toolsCategory.addPanel("Pen Size")
        increase_button = sizePanel.addLargeButton("Increase Size", icon=QIcon("brush.png"))
        increase_button.clicked.connect(self.increasePenSize)
        decrease_button = sizePanel.addLargeButton("Decrease Size", icon=QIcon("brush.png"))
        decrease_button.clicked.connect(self.decreasePenSize)

        # Help Category
        helpCategory = ribbon.addCategory("Help")
        helpPanel = helpCategory.addPanel("About")
        about_button = helpPanel.addLargeButton("About", icon=QIcon("icon.png"))  # About uses the same icon
        about_button.clicked.connect(self.showAbout)

        # Help Panel for "What Could Happen"
        futurePanel = helpCategory.addPanel("Future Plans")
        future_button = futurePanel.addLargeButton("What Could Happen", icon=None)
        future_button.clicked.connect(self.showFuturePlans)

        # Central Widget
        self.canvas = QLabel()
        self.canvas.setPixmap(QPixmap.fromImage(self.image))
        layout = QVBoxLayout()
        layout.addWidget(self.canvas)
        container = QWidget()
        container.setLayout(layout)
        self.setCentralWidget(container)
        logging.info("UI setup complete.")

    def openImage(self):
        logging.info("Opening an image.")
        filePath, _ = QFileDialog.getOpenFileName(self, "Open Image", "", "Image Files (*.png *.jpg *.bmp)")
        if filePath:
            self.image.load(filePath)
            self.canvas.setPixmap(QPixmap.fromImage(self.image))
            logging.info(f"Image loaded from {filePath}.")
        else:
            logging.warning("No file selected for opening.")

    def saveImage(self):
        logging.info("Saving the image.")
        filePath, _ = QFileDialog.getSaveFileName(self, "Save Image", "", "PNG Files (*.png)")
        if filePath:
            self.image.save(filePath)
            logging.info(f"Image saved to {filePath}.")
        else:
            logging.warning("No file selected for saving.")

    def selectColor(self):
        logging.info("Opening color picker dialog.")
        color = QColorDialog.getColor()
        if color.isValid():
            self.pen_color = color
            logging.info(f"Pen color set to {self.pen_color.name()}.")
        else:
            logging.warning("No color selected.")

    def showBucketError(self):
        logging.error("Bucket tool is not available in this version.")
        QMessageBox.critical(
            self,
            "Bucket Tool Unavailable",
            "Unfortunately, this is not available. It will be available in Version 1.1"
        )

    def increasePenSize(self):
        self.pen_size += 1
        logging.info(f"Pen size increased to {self.pen_size}.")

    def decreasePenSize(self):
        self.pen_size = max(1, self.pen_size - 1)
        logging.info(f"Pen size decreased to {self.pen_size}.")

    def showAbout(self):
        logging.info("Displaying About information.")
        QMessageBox.information(self, "About GoPaint", "GoPaint - A Python-based Image Editor\nCreated with PyQt5, GoPaint was brought to you by Zohan Haque, GoPaint Team,")

    def showFuturePlans(self):
        logging.info("Displaying future plans for GoPaint.")
        QMessageBox.information(
            self,
            "What Could Happen",
            "GoPaint would be a real Image Editor And Maker in 2.10 where it would get Brushes, and so many features"
        )

    def mousePressEvent(self, event):
        if event.button() == Qt.LeftButton:
            self.drawing = True
            self.lastPoint = event.pos()
            logging.info(f"Mouse pressed at {self.lastPoint}.")

    def mouseMoveEvent(self, event):
        if event.buttons() & Qt.LeftButton and self.drawing:
            painter = QPainter(self.image)
            pen = QPen(self.pen_color, self.pen_size, Qt.SolidLine, Qt.RoundCap, Qt.RoundJoin)
            painter.setPen(pen)
            painter.drawLine(self.lastPoint, event.pos())
            self.lastPoint = event.pos()
            self.canvas.setPixmap(QPixmap.fromImage(self.image))
            logging.info(f"Mouse moved to {self.lastPoint} while drawing.")

    def mouseReleaseEvent(self, event):
        if event.button() == Qt.LeftButton:
            self.drawing = False
            logging.info("Mouse released.")

if __name__ == "__main__":
    print("GoPaint Version 1.0 Beta")  # Starting message in the console
    print("Copyright (c) 2025 Zohan Haque")  # Starting message in the console
    print("   ")  # Starting message in the console
    app = QApplication(sys.argv)

    # Create a splash screen
    splash_pix = QPixmap("splash.png")
    splash = QSplashScreen(splash_pix, Qt.WindowStaysOnTopHint)
    splash.show()
    logging.info("Splash screen displayed.")

    # Simulate a loading process
    QTimer.singleShot(3000, splash.close)  # Close the splash screen after 3 seconds
    logging.info("Splash screen will close in 3 seconds.")

    # Launch the main application
    editor = GoPaint()
    QTimer.singleShot(3000, editor.show)  # Show the main window after the splash screen closes
    logging.info("Main window will display after the splash screen.")

    sys.exit(app.exec_())
