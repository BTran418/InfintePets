package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Employee;
import models.Servicetype;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Empservicepreference.class)
public class Empservicepreference_ { 

    public static volatile SingularAttribute<Empservicepreference, Servicetype> serviceTypeID;
    public static volatile SingularAttribute<Empservicepreference, Employee> employeeID;
    public static volatile SingularAttribute<Empservicepreference, Integer> empServicePreferenceID;

}