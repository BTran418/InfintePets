package models;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Account;
import models.Appointmentservice;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Pet.class)
public class Pet_ { 

    public static volatile SingularAttribute<Pet, String> petName;
    public static volatile SingularAttribute<Pet, Date> birthday;
    public static volatile SingularAttribute<Pet, Account> owner;
    public static volatile ListAttribute<Pet, Appointmentservice> appointmentserviceList;
    public static volatile SingularAttribute<Pet, Integer> petID;
    public static volatile SingularAttribute<Pet, String> species;
    public static volatile SingularAttribute<Pet, String> preferredVet;
    public static volatile SingularAttribute<Pet, String> imagePath;
    public static volatile SingularAttribute<Pet, Character> sex;
    public static volatile SingularAttribute<Pet, String> medicalInfo;
    public static volatile SingularAttribute<Pet, String> breed;

}