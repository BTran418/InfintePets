package models;

import java.math.BigDecimal;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Management.class)
public class Management_ { 

    public static volatile SingularAttribute<Management, Integer> itemID;
    public static volatile SingularAttribute<Management, String> itemName;
    public static volatile SingularAttribute<Management, String> itemLink;
    public static volatile SingularAttribute<Management, BigDecimal> itemPrice;
    public static volatile SingularAttribute<Management, String> itemDescription;

}