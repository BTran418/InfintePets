package models;

import java.math.BigDecimal;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Appointmentservice;
import models.Discount;
import models.Employee;
import models.Empqualification;
import models.Servicetype;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Service.class)
public class Service_ { 

    public static volatile ListAttribute<Service, Discount> discountList;
    public static volatile ListAttribute<Service, Appointmentservice> appointmentserviceList;
    public static volatile ListAttribute<Service, Employee> employeeList;
    public static volatile ListAttribute<Service, Empqualification> empqualificationList;
    public static volatile SingularAttribute<Service, Boolean> active;
    public static volatile SingularAttribute<Service, Servicetype> serviceTypeID;
    public static volatile SingularAttribute<Service, String> serviceDescription;
    public static volatile SingularAttribute<Service, Integer> serviceID;
    public static volatile SingularAttribute<Service, String> serviceName;
    public static volatile SingularAttribute<Service, BigDecimal> basePrice;

}