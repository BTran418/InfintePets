package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Empservicepreference;
import models.Service;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Servicetype.class)
public class Servicetype_ { 

    public static volatile SingularAttribute<Servicetype, String> serviceType;
    public static volatile ListAttribute<Servicetype, Empservicepreference> empservicepreferenceList;
    public static volatile ListAttribute<Servicetype, Service> serviceList;
    public static volatile SingularAttribute<Servicetype, Integer> serviceTypeID;

}