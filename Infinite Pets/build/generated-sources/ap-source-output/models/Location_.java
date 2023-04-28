package models;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Account;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Location.class)
public class Location_ { 

    public static volatile SingularAttribute<Location, String> area;
    public static volatile SingularAttribute<Location, String> country;
    public static volatile SingularAttribute<Location, String> address;
    public static volatile SingularAttribute<Location, String> province;
    public static volatile SingularAttribute<Location, String> city;
    public static volatile SingularAttribute<Location, Integer> locationID;
    public static volatile SingularAttribute<Location, String> postalCode;
    public static volatile ListAttribute<Location, Account> accountList;
    public static volatile SingularAttribute<Location, Character> locationType;

}