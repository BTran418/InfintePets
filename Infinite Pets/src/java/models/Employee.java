/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author BTran
 */
@Entity
@Table(name = "employee")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Employee.findAll", query = "SELECT e FROM Employee e")
    , @NamedQuery(name = "Employee.findByEmployeeID", query = "SELECT e FROM Employee e WHERE e.employeeID = :employeeID")
    , @NamedQuery(name = "Employee.findByIsAdmin", query = "SELECT e FROM Employee e WHERE e.isAdmin = :isAdmin")
    , @NamedQuery(name = "Employee.findByOnVacation", query = "SELECT e FROM Employee e WHERE e.onVacation = :onVacation")
    , @NamedQuery(name = "Employee.findByActive", query = "SELECT e FROM Employee e WHERE e.active = :active")
    , @NamedQuery(name = "Employee.findByUserID", query = "SELECT e FROM Employee e WHERE e.userID = :userID")})
public class Employee implements Serializable {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "employeeID", fetch = FetchType.EAGER)
    private List<Empqualification> empqualificationList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "EmployeeID")
    private Integer employeeID;
    @Basic(optional = false)
    @Column(name = "IsAdmin")
    private boolean isAdmin;
    @Basic(optional = false)
    @Column(name = "OnVacation")
    private boolean onVacation;
    @Basic(optional = false)
    @Column(name = "Active")
    private boolean active;
    @JoinTable(name = "empqualification", joinColumns = {
        @JoinColumn(name = "EmployeeID", referencedColumnName = "EmployeeID")}, inverseJoinColumns = {
        @JoinColumn(name = "ServiceID", referencedColumnName = "ServiceID")})
    @ManyToMany(fetch = FetchType.EAGER)
    private List<Service> serviceList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "employeeID", fetch = FetchType.EAGER)
    private List<Empservicepreference> empservicepreferenceList;
    @OneToMany(mappedBy = "employeeID", fetch = FetchType.EAGER)
    private List<Appointment> appointmentList;
    @JoinColumn(name = "UserID", referencedColumnName = "UserId")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private Account userID;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "employee", fetch = FetchType.EAGER)
    private List<Schedule> scheduleList;

    public Employee() {
    }

    public Employee(Integer employeeID) {
        this.employeeID = employeeID;
    }

    public Employee(Integer employeeID, boolean isAdmin, boolean onVacation, boolean active) {
        this.employeeID = employeeID;
        this.isAdmin = isAdmin;
        this.onVacation = onVacation;
        this.active = active;
    }

    public Integer getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(Integer employeeID) {
        this.employeeID = employeeID;
    }

    public boolean getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    public boolean getOnVacation() {
        return onVacation;
    }

    public void setOnVacation(boolean onVacation) {
        this.onVacation = onVacation;
    }

    public boolean getActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    @XmlTransient
    public List<Service> getServiceList() {
        return serviceList;
    }

    public void setServiceList(List<Service> serviceList) {
        this.serviceList = serviceList;
    }

    @XmlTransient
    public List<Empservicepreference> getEmpservicepreferenceList() {
        return empservicepreferenceList;
    }

    public void setEmpservicepreferenceList(List<Empservicepreference> empservicepreferenceList) {
        this.empservicepreferenceList = empservicepreferenceList;
    }

    @XmlTransient
    public List<Appointment> getAppointmentList() {
        return appointmentList;
    }

    public void setAppointmentList(List<Appointment> appointmentList) {
        this.appointmentList = appointmentList;
    }

    public Account getUserID() {
        return userID;
    }

    public void setUserID(Account userID) {
        this.userID = userID;
    }

    @XmlTransient
    public List<Schedule> getScheduleList() {
        return scheduleList;
    }

    public void setScheduleList(List<Schedule> scheduleList) {
        this.scheduleList = scheduleList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (employeeID != null ? employeeID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Employee)) {
            return false;
        }
        Employee other = (Employee) object;
        if ((this.employeeID == null && other.employeeID != null) || (this.employeeID != null && !this.employeeID.equals(other.employeeID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.Employee[ employeeID=" + employeeID + " ]";
    }

    @XmlTransient
    public List<Empqualification> getEmpqualificationList() {
        return empqualificationList;
    }

    public void setEmpqualificationList(List<Empqualification> empqualificationList) {
        this.empqualificationList = empqualificationList;
    }
    
}
