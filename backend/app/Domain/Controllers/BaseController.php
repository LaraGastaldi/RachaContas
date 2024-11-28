<?php

namespace App\Domain\Controllers;

use App\Domain\Services\BaseService;
use Exception;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * Classe base do controlador.
 * Todos os métodos devem ser protegidos, para que o método mágico __call possa ser utilizado, evelopando a resposta.
 */
abstract class BaseController
{
    /**
     * O resource que será utilizado pelo controlador.
     * Essa propriedade deve ser setada na classe filha como ExemploResource::class.
     * @var string
     */
    protected $resource;
    /**
     * O service que será utilizado pelo controlador.
     * Essa propriedade deve ser setada na classe filha como ExemploService::class.
     * @var string|BaseService
     */
    protected $service;

    public function __construct()
    {
        if ($this->service) {
            $this->service = new $this->service();
        }
    }


    protected function create(Request $request)
    {
        return $this->service->create($request->all());
    }

    protected function update(int $id, Request $request)
    {
        return $this->service->update($id, $request->all());
    }

    protected function delete(int $id)
    {
        return $this->service->delete($id);
    }

    protected function find(int $id)
    {
        return $this->service->find($id);
    }

    protected function all()
    {
        return $this->service->all();
    }

    /**
     * Todas as calls devem passar por esse método mágico
     * @return JsonResource $resource
     */
    public function __call($method, $args)
    {
        $response = $this->$method(...$args);

        if ($response instanceof Collection || $response instanceof \Illuminate\Support\Collection) {
            return $this->resource::collection($response);
        }

        if ($response instanceof Model) {
            return new $this->resource($response);
        }

        return $response;
    }
}