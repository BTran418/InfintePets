package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Appointment;
import models.Pet;
import models.Service;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Appointmentservice.class)
public class Appointmentservice_ { 

    public static volatile SingularAttribute<Appointmentservice, Integer> appServID;
    public static volatile SingularAttribute<Appointmentservice, Pet> petID;
    public static volatile SingularAttribute<Appointmentservice, Appointment> appointmentID;
    public static volatile SingularAttribute<Appointmentservice, Service> serviceID;

}