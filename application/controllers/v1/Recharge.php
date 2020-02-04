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
class Recharge extends CI_Controller {
    use REST_Controller { REST_Controller::__construct as private __resTraitConstruct; }

    function __construct(){
        // Construct the parent class
        parent::__construct();
        $this->__resTraitConstruct();
        $this->load->model('User_model');
    }

    function index_post(){
        $postData = $this->input->post();
        
        $userData['username'] = $postData['username'];
        $userData['profile']  = $postData['profile'];
        $userData['currentprofile']  = $userData['profile'];
        $profileData = $this->User_model->getProfileDuration($postData['profile']);
        $userData['expirydate'] = date('Y:m:d H:i:s',strtotime($profileData['value'].' '.$profileData['unit'],time()));
        
        $this->User_model->profileUpdate($userData);
        $this->RESPONSE = 'SUCCESS';
        $this->response(array($userData,'RES'=>$this->RESPONSE), 200);
    }

}
