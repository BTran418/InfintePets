package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Appointment;
import models.Employee;
import models.Location;
import models.Pet;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Account.class)
public class Account_ { 

    public static volatile SingularAttribute<Account, String> lastName;
    public static volatile SingularAttribute<Account, Boolean> isEmployee;
    public static volatile SingularAttribute<Account, Location> address;
    public static volatile ListAttribute<Account, Pet> petList;
    public static volatile ListAttribute<Account, Appointment> appointmentList;
    public static volatile SingularAttribute<Account, String> passwordResetCode;
    public static volatile SingularAttribute<Account, Integer> userId;
    public static volatile SingularAttribute<Account, String> passwordHash;
    public static volatile SingularAttribute<Account, String> firstName;
    public static volatile ListAttribute<Account, Employee> employeeList;
    public static volatile SingularAttribute<Account, Boolean> passwordResetActive;
    public static volatile SingularAttribute<Account, Boolean> isConfirmed;
    public static volatile SingularAttribute<Account, String> passwordSalt;
    public static volatile SingularAttribute<Account, String> email;
    public static volatile SingularAttribute<Account, String> deleteAccountCode;

}