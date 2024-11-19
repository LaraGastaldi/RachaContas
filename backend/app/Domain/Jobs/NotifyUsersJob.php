<?php
 
namespace App\Domain\Jobs;
 
use App\Domain\Enum\UserToDebtRelationship;
use App\Domain\Models\Debt;
use App\Domain\Models\UserToDebt;
use App\Mail\DebtNotification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\Mail;
 
class NotifyUsersJob implements ShouldQueue
{
    use Queueable;
 
    /**
     * Create a new job instance.
     */
    public function __construct(
        public Debt $debt,
    ) {}
 
    /**
     * Execute the job.
     */
    public function handle(): void
    {
        $this->debt->users->each(function (UserToDebt $user) {
            if ($user->relationship != UserToDebtRelationship::PAYER) return;

            if ($user->email != null) {
                Mail::to($user->email)->send(new DebtNotification($this->debt, $user));
            }

            if ($user->phone != null) {
                // Send SMS
            }
        });
    }
}