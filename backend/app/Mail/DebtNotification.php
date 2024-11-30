<?php

namespace App\Mail;

use App\Domain\Enum\ProofType;
use App\Domain\Models\Debt;
use App\Domain\Models\UserToDebt;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Attachment;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Storage;

class DebtNotification extends Mailable
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
            subject: $this->user->name . ', confirme sua dívida',
            to: $this->user->email,
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content  
    {
        return new Content(
            view: 'mail.verify-your-debt',
            with: [
                'debt' => $this->debt,
                'user' => $this->user,
            ],
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return $this->debt->proofs->filter(fn ($proof) => $proof->type == ProofType::RECEIPT)
        ->map(function ($proof, $idx) {
            $attach = Attachment::fromData(fn () => $proof->src, "comprovante$idx.jpeg")->withMime('image/jpeg');
            return $attach;
        })
        ->toArray();
    }
}
