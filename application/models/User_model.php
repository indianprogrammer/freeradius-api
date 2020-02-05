<?php

class User_model extends CI_Model {
    public function __construct()   {
        $this->load->database();
    }

    public function insert($userData){
        $this->db->insert('users',$userData);
        return ($this->db->affected_rows() != 1) ? false : true;
    }

    public function profileUpdate($userData){
        $this->db->where('username', $userData['username']);
        $this->db->update('users',$userData);
        return ($this->db->affected_rows() != 1) ? false : true;
    }

    public function getProfileDuration($profile){
        $this->db->select('op as unit, value');
        $query = $this->db->get_where('profiles',array('attribute'=>'DURATION','profile'=>$profile));
        return $query->row_array();
    }

    public function getDetails($username){
        $this->db->select('id,username,password,profile,currentprofile,expirydate,ipaddress,macaddress,macbind,status,created,updated');
        $query = $this->db->get_where('users',array('username'=>$username));
        return $query->row_array();
    }
}

?>