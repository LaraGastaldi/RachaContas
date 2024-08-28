<?php

namespace App\Domain\Services;

use SimpleXMLElement;

class XmlConverterService extends BaseConverterService
{
    protected $rootElement;

    public function __construct($rootElement = 'root')
    {
        $this->rootElement = $rootElement;
    }

    public function convertToArray($xml)
    {
        $xml = simplexml_load_string($xml);
        $json = json_encode($xml);
        return json_decode($json, true);
    }

    public function convertArray($array)
    {
        return $this->arrayToXml($array);
    }

    protected function arrayToXml($array, $xml = false) {

        if($xml === false){
            $xml = new SimpleXMLElement("<{$this->rootElement}/>");
        }
    
        foreach($array as $key => $value){
            if(is_array($value)){
                $this->arrayToXml($value, $xml->addChild($key));
            } else {
                $xml->addChild($key, $value);
            }
        }
    
        return $xml->asXML();
    }
}