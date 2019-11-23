package ca.ubc.cs304.controller;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.delegates.ClerkTransactionDelegate;
import ca.ubc.cs304.ui.MainOperations;
import ca.ubc.cs304.ui.RentVehicleWindow;

import javax.swing.*;

public class ClerkController implements ClerkTransactionDelegate {
    private DatabaseConnectionHandler dbHandler = null;
    private JFrame currentWindow = null;

    public ClerkController(JFrame currentWindow) {
        this.currentWindow = currentWindow;
        dbHandler = DatabaseConnectionHandler.getDBHandlerInstance();
    }

	@Override
	public void rentVehicle() {
		currentWindow.dispose();
        RentVehicleWindow rentVehicleWindow = new RentVehicleWindow();
        RentController rentController = new RentController(rentVehicleWindow);
        rentVehicleWindow.showMenu(rentController);
	}

	@Override
	public void returnVehicle() {
		System.out.println(dbHandler.returnVehicle()); // prints error returned from returnVehicle
	}

    @Override
    public void mainMenu() {
        currentWindow.dispose();
        MainOperations mainOperations = new MainOperations();
        MainController mainController = new MainController(mainOperations);
        mainOperations.showMenu(mainController);
    }
}
