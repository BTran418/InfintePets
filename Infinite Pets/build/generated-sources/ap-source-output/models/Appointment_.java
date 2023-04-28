package models;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Account;
import models.Appointmentservice;
import models.Employee;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Appointment.class)
public class Appointment_ { 

    public static volatile ListAttribute<Appointment, Appointmentservice> appointmentserviceList;
    public static volatile SingularAttribute<Appointment, Account> clientID;
    public static volatile SingularAttribute<Appointment, Date> appointmentTime;
    public static volatile SingularAttribute<Appointment, Date> endDate;
    public static volatile SingularAttribute<Appointment, Integer> appointmentID;
    public static volatile SingularAttribute<Appointment, Boolean> paid;
    public static volatile SingularAttribute<Appointment, Boolean> active;
    public static volatile SingularAttribute<Appointment, Employee> employeeID;
    public static volatile SingularAttribute<Appointment, Date> appointmentDate;
    public static volatile SingularAttribute<Appointment, Boolean> confirmed;

}