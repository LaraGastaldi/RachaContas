<html>
    <body style="max-width: 500px;">
        <table style="text-align: center;">
            <tr style="background-color: #80c783; color: black;">
                <td>
                    <h2>Olá {{ $user['name'] }}, uma dívida foi registrada em seu e-mail.</h2>
                </td>
            </tr>
            <tr>
                <td>
                    <p>{{ $debt->user->first_name . ' ' . $debt->user->last_name }} registrou uma dívida no valor de R$ {{ number_format($user['value'] == 0 ? $debt['total_value'] : ($user['value']), 2) }}</p>
                </td>
            </tr>
            <tr>
                <td>
                    Confirme sua dívida pelo link abaixo{{ $debt['max_pay_date'] != null ? 
                        (', para receber o lembrete do pagamento no dia ' . \Carbon\Carbon::parse($debt['max_pay_date'])->locale('pt_BR')->format('dd \d\e F \d\e Y'))
                        : '' }}:
                </td>
            </tr>
            <tr>
                <td>
                    <hr/>
                </td>
            <tr>
                <td>
                    <a 
                        href="{{ env('VERIFY_URL') }}/{{ $user['verify_code'] }}"
                        style="border: 0; background-color: #80c783; color: black; padding: 10px 16px; border-radius: 10px;">Acessar</a>
                </td>
            </tr>
            <tr>
                <td>
                    <hr/>
                </td>
            <tr>
            <tr>
                <td>Ou copie e cole o link abaixo:</td>
            </tr>
            <tr>
                <td>
                    <a>{{ env('VERIFY_URL') }}/{{ $user['verify_code'] }}</a>
                </td>
            </tr>
        </table>
    </body>
</html>