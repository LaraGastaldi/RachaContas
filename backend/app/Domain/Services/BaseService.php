<?php

namespace App\Domain\Services;

use App\Domain\Repository\BaseRepository;

/**
 * Classe base do serviço.
 * O serviço é responsável por fazer a comunicação com o repositório.
 */
abstract class BaseService
{
    /**
     * Essa propriedade deve ser setada na classe filha como ExemploRepository::class.
     * @var string|BaseRepository
     */
    protected $repository;

    public function __construct()
    {
        $this->repository = new $this->repository();
    }

    /**
     * @param array<string, mixed> $data
     * @return mixed
     */
    public function create(array $data)
    {
        return $this->repository->create($data);
    }

    /**
     * @param int $id
     * @return mixed
     */
    public function find(int $id)
    {
        return $this->repository->find($id);
    }

    /**
     * @param int $id
     * @param array<string, mixed> $data
     * @return mixed
     */
    public function update(int $id, array $data)
    {
        $model = $this->repository->find($id);
        $model->update($data);
        return $model;
    }

    /**
     * @param int $id
     * @return bool
     */
    public function delete(int $id)
    {
        return $this->repository->delete($id);
    }

    /**
     * @return mixed
     */
    public function all()
    {
        return $this->repository->all();
    }

    /**
     * @param array<string, mixed> $data
     * @return mixed
     */
    public function updateOrCreate(array $data)
    {
        return $this->repository->updateOrCreate($data);
    }
}