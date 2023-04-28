package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Account;
import models.Appointment;
import models.Empqualification;
import models.Empservicepreference;
import models.Schedule;
import models.Service;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Employee.class)
public class Employee_ { 

    public static volatile SingularAttribute<Employee, Boolean> onVacation;
    public static volatile ListAttribute<Employee, Schedule> scheduleList;
    public static volatile ListAttribute<Employee, Empservicepreference> empservicepreferenceList;
    public static volatile ListAttribute<Employee, Service> serviceList;
    public static volatile ListAttribute<Employee, Empqualification> empqualificationList;
    public static volatile SingularAttribute<Employee, Boolean> active;
    public static volatile ListAttribute<Employee, Appointment> appointmentList;
    public static volatile SingularAttribute<Employee, Integer> employeeID;
    public static volatile SingularAttribute<Employee, Boolean> isAdmin;
    public static volatile SingularAttribute<Employee, Account> userID;

}