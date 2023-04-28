package models;

import java.math.BigDecimal;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Promotion;
import models.Service;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Discount.class)
public class Discount_ { 

    public static volatile SingularAttribute<Discount, BigDecimal> discount;
    public static volatile SingularAttribute<Discount, Character> discountType;
    public static volatile SingularAttribute<Discount, Promotion> promoID;
    public static volatile SingularAttribute<Discount, Integer> discountID;
    public static volatile SingularAttribute<Discount, Service> serviceID;

}