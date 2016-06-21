<?php
class ControllerCommonLogout extends Controller {
	public function index() {
		$this->user->logout();


		unset($this->session->data['token']);
		unset($this->session->data['tokenHidden']);

		$this->response->redirect($this->url->link('common/login', '', 'SSL'));
	}
}