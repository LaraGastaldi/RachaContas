@extends('layouts.app')

<div class="container-fluid d-flex justify-content-center align-items-center" style="background-color: #80c783; height: 100vh;">
    <div class="container bg-white border p-3 card">
        @if($user->verified_at != null)
            <div class="text-success my-4">
                Olá {{ $user->name }}, sua dívida já foi validada!
            </div>
        @else
        <h2>Olá {{ $user->name }}, você tem uma dívida</h2>
        <p>{{ $debt->user->first_name }} registrou uma dívida em seu e-mail</p>
        <p>Valor: R$ {{ number_format($user->value != null ? $user->value : $debt->total_value, 2) }}</p>
        <p>Se você recohece essa dívida, confirme-a com o botão abaixo:</p>
        <form action="{{ route('user-to-debt.verify', $user->id) }}" method="POST">
            @csrf
            <div class="form-check mb-4">
                <input class="form-check-input" type="checkbox" value="1" id="verify" name="verify" required>
                <label class="form-check">Eu confirmo essa dívida</label>
            </div>
            <div class="d-block text-center">
                <button class="btn btn-success btn-lg" type="submit">Validar dívida</button>
            </div>
        </form>
        <p class="small text-secondary">É importante que a dívida seja validada para que você receba um lembrete, se tiver data máxima para pagar</p>
        @endif

        <p class="small text-secondary text-center">Racha Contas</p>
    </div>
</div>
