package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Employee;
import models.Service;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Empqualification.class)
public class Empqualification_ { 

    public static volatile SingularAttribute<Empqualification, Integer> empQualificationID;
    public static volatile SingularAttribute<Empqualification, Employee> employeeID;
    public static volatile SingularAttribute<Empqualification, Service> serviceID;

}