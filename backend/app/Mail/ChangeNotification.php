<?php

namespace App\Mail;

use App\Domain\Enum\ProofType;
use App\Domain\Models\Debt;
use App\Domain\Models\UserToDebt;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Attachment;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class ChangeNotification extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     */
    public function __construct(protected Debt $debt, protected UserToDebt $user)
    {
        //
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: $this->user->name . ', houve uma alteração na sua dívida!',
            to: $this->user->email,
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'view.mail.changes-in-debt',
            with: [
                'debt' => $this->debt,
                'user' => $this->user,
            ],
        );
    }
}
