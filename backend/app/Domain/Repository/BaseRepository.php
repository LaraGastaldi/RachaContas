<?php

namespace App\Domain\Repository;

use App\Domain\Models\Debt;
use Illuminate\Database\Eloquent\Model;

/**
 * Classe base do repositório.
 * O repository é responsável por fazer a comunicação com o banco de dados.
 * Não deve haver nenhuma lógica em classes de repositório.
 */
abstract class BaseRepository
{
    /**
     * O model que será utilizado pelo repositório.
     * Essa propriedade deve ser setada na classe filha como ExemploModel::class.
     * @var string
     */
    protected $model;

    /**
     * @param array<string, mixed> $data
     * @return mixed
     */
    public function create(array $data)
    {
        return $this->model::create($data);
    }

    /**
     * @param int $id
     * @return mixed
     */
    public function find(int $id)
    {
        return $this->model::find($id);
    }

    /**
     * @param int $id
     * @param array<string, mixed> $data
     * @return mixed
     */
    public function update(int $id, array $data)
    {
        $model = $this->model::find($id);
        $model->update($data);
        return $model;
    }

    /**
     * @param int $id
     * @return bool
     */
    public function delete(int $id)
    {
        return $this->model::destroy($id);
    }

    /**
     * @return mixed
     */
    public function all()
    {
        return $this->model::all();
    }

    /**
     * @param array<string, mixed> $data
     * @return mixed
     */
    public function updateOrCreate(array $data)
    {
        $id = $data['id'];
        unset($data['id']);
        return $this->model::updateOrCreate(['id' => $id], $data);
    }
}