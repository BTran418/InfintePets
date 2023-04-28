package models;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import models.Employee;
import models.SchedulePK;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2023-03-15T00:45:53")
@StaticMetamodel(Schedule.class)
public class Schedule_ { 

    public static volatile SingularAttribute<Schedule, Date> startTime;
    public static volatile SingularAttribute<Schedule, Date> endTime;
    public static volatile SingularAttribute<Schedule, Employee> employee;
    public static volatile SingularAttribute<Schedule, SchedulePK> schedulePK;

}