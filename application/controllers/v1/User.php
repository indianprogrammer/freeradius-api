<?php
use Restserver\Libraries\REST_Controller;
defined('BASEPATH') OR exit('No direct script access allowed');

// This can be removed if you use __autoload() in config.php OR use Modular Extensions
/** @noinspection PhpIncludeInspection */
//To Solve File REST_Controller not found
require APPPATH . 'libraries/REST_Controller.php';
require APPPATH . 'libraries/Format.php';

/**
 * This is an example of a few basic user interaction methods you could use
 * all done with a hardcoded array
 *
 * @package         CodeIgniter
 * @subpackage      Rest Server
 * @category        Controller
 * @author          Phil Sturgeon, Chris Kacerguis
 * @license         MIT
 * @link            https://github.com/chriskacerguis/codeigniter-restserver
 */
class User extends CI_Controller {
    use REST_Controller { REST_Controller::__construct as private __resTraitConstruct; }
    private $RESPONSE = 'ALREADYEXIST';

    function __construct(){
        // Construct the parent class
        parent::__construct();
        $this->__resTraitConstruct();
        $this->load->model('User_model');
    }

    function add_post(){
        $postData = $this->input->post();
        $profile  = $this->input->post('profile');

        $userData['username'] = $postData['username'];
        $userData['password'] = isset($postData['password'])?$postData['password']:$postData['username'];
        $userData['status'] = isset($postData['status'])?$postData['status']:'ENABLE';
        $userData['profile']  = isset($postData['profile'])?$postData['profile']:'EXPIRED';
        $userData['currentprofile']  = $userData['profile'];
        $profileData = $this->User_model->getProfileDuration($profile);
        $userData['expirydate']  = isset($postData['expirydate'])?urldecode($postData['expirydate']) :date('Y:m:d H:i:s',strtotime($profileData['value'].' '.$profileData['unit'],time()));

        $flagUserCreation = $this->User_model->insert($userData);
        if($flagUserCreation){
            $this->RESPONSE = 'CREATED';
        }else{
            $flagProfileUpdate = $this->User_model->profileUpdate($userData);
        }
        $this->response(array($userData,'RES'=>$this->RESPONSE), 200);
    }

    function getdetails_get(){
        $this->RESPONSE = 'SUCCESS';
        $getData = $this->input->get();
        if(isset($getData['username'])){
            $userDetails = $this->User_model->getDetails($getData['username']);
            $this->response(array('userdetails'=>$userDetails,'RES'=>$this->RESPONSE), 200);
        }
        $this->RESPONSE = 'ERROR';
        $this->response(array('RES'=>$this->RESPONSE), 400);
    }

    function index_get(){
        echo "V1";
    }

}
