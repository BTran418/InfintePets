package models;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Discount;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Promotion.class)
public class Promotion_ { 

    public static volatile ListAttribute<Promotion, Discount> discountList;
    public static volatile SingularAttribute<Promotion, String> promotionName;
    public static volatile SingularAttribute<Promotion, Date> endDate;
    public static volatile SingularAttribute<Promotion, Boolean> active;
    public static volatile SingularAttribute<Promotion, Integer> promoID;
    public static volatile SingularAttribute<Promotion, String> promoDescription;
    public static volatile SingularAttribute<Promotion, Date> startDate;

}