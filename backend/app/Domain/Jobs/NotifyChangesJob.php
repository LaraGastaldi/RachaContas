<?php
 
namespace App\Jobs;
 
use App\Domain\Models\Debt;
use App\Domain\Models\UserToDebt;
use App\Mail\DebtNotification;
use App\Models\Podcast;
use App\Services\AudioProcessor;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\Mail;
 
class NotifyChangesJob implements ShouldQueue
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
            if ($user->email != null) {
                Mail::to($user->email)->send(new DebtNotification($this->debt, $user));
            }

            if ($user->phone != null) {
                // Send SMS
            }
        });
    }
}