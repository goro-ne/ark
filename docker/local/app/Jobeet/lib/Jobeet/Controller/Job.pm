package Jobeet::Controller::Job;
use Ark 'Controller';
with 'Ark::ActionClass::Form';

use Jobeet::Models;
has '+namespace' => default => 'job';

use Data::Dumper;
use Class::Inspector;
use Scalar::Util qw/blessed/;


sub auto :Private {
    1;
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    # $c->stash->{jobs} = models('Schema::Job');
    $c->stash->{jobs} = models('Schema::Job')->get_active_jobs;
    $c->stash->{categories} = models('Schema::Category')->get_with_jobs;
    $c->stash->{rows} = "bbb";


}

# /job/{job_token} (詳細)
sub show :Path :Args(1) {
    my ($self, $c, $job_token) = @_;
    $c->stash->{pager} = 1;
    $c->stash->{job} = models('Schema::Job')->find({ token=> $job_token })
        or $c->detach('/default');
}

# /job/create (新規作成)
sub create :Local :Form('Jobeet::Form::Job') {
    my ($self, $c) = @_;

    if ($c->req->method eq 'POST' and $self->form->submitted_and_valid) {
        # バリデーション成功後に、求人を作成する
        my $job = models('Schema::Job')->create_from_form($self->form);
        $c->redirect( $c->uri_for('/job', $job->token) );
    }
    $c->stash->{form} = $self->form;
}

# /job/{job_token} (トークンをつける)
sub job :Chained('/') :PathPart :CaptureArgs(1) {
    my ($self, $c, $job_token) = @_;
    $c->stash->{job} = models('Schema::Job')->find({ token => $job_token })
        or $c->detach('/default');
}


# /job/{job_token}/edit (編集)
sub edit :Chained('job') :PathPart :Form('Jobeet::Form::Job') {
    my ($self, $c) = @_;

    my $job = $c->stash->{job};

    if ($c->req->method eq 'POST') {
        if ($self->form->submitted_and_valid) {
            $job->update_from_form($self->form);
            $c->redirect( $c->uri_for('/job', $job->token) );
        }
    }
    else {
        $self->form->fill({
            $job->get_columns,
            category => $job->category->slug,
        });
    }
}

# /job/{job_token}/delete (削除)
sub delete :Chained('job') :PathPart {
    my ($self, $c) = @_;

    $c->stash->{job}->delete;
    $c->redirect( $c->uri_for('/job') );
}

__PACKAGE__->meta->make_immutable;

