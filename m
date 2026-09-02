Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6404A4829
	for <gfs2@lists.linux.dev>; Wed,  2 Sep 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360551; cv=none; b=VKqqlr2vwILROfZGH/vBMsz3SRm7ylDDgnZyY6PZxVOlwW4+8Fu1CXP+vOCp9wnQeSdkXlQKj33Nrst6vc93/biGZAOOG67yojvKq+wPnaQkIgVQKB4UFpgLiVMuZYW67TDubRcmc9gKHmqVR1VZQqX23UBYDp5R90PwALUWksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360551; c=relaxed/simple;
	bh=T+Fbm/zEO1JT4syG834Lukx0Oo/rqPXgi0S49eo8Hls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikm0NqSj+M+EwuFIXB0ZeUB5bS4bEvfVkfird16W2ONxsIywERO4UprdhVH+NjR542RyVhumkvS9+P5Jy7z/2ESnPBlPic35e/fXP+bpIdLTzVSJ2c574vdjpjEIJJo6YVJGBEOdZMvY/KHl2WwRKoK9Iz8Yatj9P04pigu8ks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1SS9kBh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1SS9kBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788360546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZM0PDfVUjjwLjTZVTYLBQV+0Mf1xQqcsXt17+bwkLQ=;
	b=X1SS9kBhNsn4BTpS+RwVnWjsmhVTcPAS9zJ6N4kB092ujbnCiOpJNpdYZGMexY/MbYl6+P
	JHRGNRIafQs6L2WeSwjnpCGwMsWB682tSl4NTq/6+ncoFBqkBOeK+YzgaYhP34Gz0VUGSp
	e7rADsA+8FM0ywYa0bGR3kxqU4D4350=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-pv1qFhfZOk6W6DspgmBs7g-1; Wed, 02 Sep 2026 10:49:05 -0400
X-MC-Unique: pv1qFhfZOk6W6DspgmBs7g-1
X-Mimecast-MFC-AGG-ID: pv1qFhfZOk6W6DspgmBs7g_1788360544
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-39c9666682bso5093731fa.3
        for <gfs2@lists.linux.dev>; Wed, 02 Sep 2026 07:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788360544; x=1788965344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZM0PDfVUjjwLjTZVTYLBQV+0Mf1xQqcsXt17+bwkLQ=;
        b=Mu8DfLZm9VT6AUJYsWQdJSkgbRxmH6K76G+o65WmumxFS9g/O54qq2hd3dwdfXSk1C
         V40BmDD5YCP4z9SlXBc/63U4oKEtQVsIcvArpqx5RrnkLYq/GqH5g7uQD0z3Mm5CytoJ
         j6Ca29PZUWlKLjcS6wodO9BFc99bfqyT74x2kqPnh8h7q2OPxg0uzERV3r90hBW++XuZ
         L7Tr24IQ7nN5E3uDmFDn2LuwRp199xezhF0tzEYQ33EDkFUnt84qzy+P5+wLshn1/aXN
         yMUjH3jNq1PosV8gwgjJxefBN6wngM2sW/YAr2gR9Wpd9V30ZUZFYOdjAcYfpVRmVtjA
         yDOQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8RnFdbKwz6zT62Lx55QxsqkWiNkqmoYWOn8gU1CoNJkDqW9kwu/dQ6Su21NOoT++0/tyK@lists.linux.dev
X-Gm-Message-State: AFuF++lVfddQudRw22LidCsP6ga36FSYZhOH/B7FLPVS4LebDzHmVHVL
	c877XEX+2ggoiLRCYswHpJK+Yixu6Ip/668J906Ry6mFas78y51iQenYSYkgUmcxw3krg5rsuRS
	tFHbgVUq9lYafQQxclZcqDTWcE6/9XBZq6Y68i8oCSX3hoT0TfZQY7PcORVVa3rwmvGTVZeQ+de
	7durhke7X7d4aD/esiLyMabHmnXaogMQ==
X-Gm-Gg: AYBFou00LgUo5pR4e0tmdvi443QxCNr5nJPJ9AcS4l86Ghsv37vDAc1n4UyDS6D+xQN
	rT6t2hTasVksiEbT8I18nQByOgx30DdKoL3+yb23N6VPvYs4+zVCxDwpk4qkaxKSZb4Y2dFGc7F
	Itc7neCMeXciAZYgJ3h9q1iVpU5vtTDcKCXgN8/FWB1NbBxNFOa0kCSc+j
X-Received: by 2002:a2e:bc09:0:b0:3a3:22f6:51a2 with SMTP id 38308e7fff4ca-3a34fdcd931mr10371841fa.12.1788360543651;
        Wed, 02 Sep 2026 07:49:03 -0700 (PDT)
X-Received: by 2002:a2e:bc09:0:b0:3a3:22f6:51a2 with SMTP id
 38308e7fff4ca-3a34fdcd931mr10371731fa.12.1788360543099; Wed, 02 Sep 2026
 07:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260901091836.16906-1-qiang.zhang@linux.dev> <CAK-6q+jFXsZpWHrm0CSa8Tr+P3qHDmWVQA+9stXViyUf48CuvA@mail.gmail.com>
 <b530646295a64f5e1cec5bfec5064f1fc79d3d9d@linux.dev> <CAK-6q+hr12xynik0e5sm_s2z_W31F3X1rSovxHJ8R-4f42tSpQ@mail.gmail.com>
In-Reply-To: <CAK-6q+hr12xynik0e5sm_s2z_W31F3X1rSovxHJ8R-4f42tSpQ@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 2 Sep 2026 10:48:51 -0400
X-Gm-Features: AcwNN1UnmnZcXkT_iAGs61hpMPGkMVj7f5nC8b5LfPIW9S94Qxf9J3t5mOd2D-U
Message-ID: <CAK-6q+gNbyFSOhZdA2z1J9SkTeGudgiux9-zgMMhtUP3LoUx1w@mail.gmail.com>
Subject: Re: [PATCH] dlm: wait for outstanding SRCU callbacks to complete in
 exit paths
To: Zqiang <qiang.zhang@linux.dev>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ijdq_PlNnSGyu_vQ7BbrbLos0_om7xXC0B3ROj_q2Eo_1788360544
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 2, 2026 at 10:30=E2=80=AFAM Alexander Aring <aahringo@redhat.co=
m> wrote:
>
> Hi,
>
> On Wed, Sep 2, 2026 at 10:16=E2=80=AFAM Zqiang <qiang.zhang@linux.dev> wr=
ote:
> >
> > >
> > > Hi,
> > >
> > > On Tue, Sep 1, 2026 at 5:19 AM Zqiang <qiang.zhang@linux.dev> wrote:
> > >
> > > >
> > > > The dlm_lowcomms_exit() and dlm_midcomms_exit() iterate over the
> > > >  srcu protected connection and node hash tables and hand each
> > > >  element to call_srcu() for deferred freeing (connection_release()
> > > >  and midcomms_node_release()). call_srcu() is asynchronous: the
> > > >  callbacks are invoked only after an SRCU grace period, which may
> > > >  happen after the exit function has already returned.
> > > >
> > > >  These exit functions are reached from exit_dlm() on module unload.
> > > >  Once they return, module teardown continues and the module text
> > > >  may be unloaded while call_srcu() callbacks are still pending. Whe=
n
> > > >  such a callback finally runs, it executes freed module code and
> > > >  touches the static SRCU domains that are being torn down, resultin=
g
> > > >  in a use-after-free.
> > > >
> > > I thought again about this and in my opinion this is not possible as
> > > it is already being handled by DEFINE_STATIC_SRCU() with a cleanup
> > > handling when the module is unloaded.
> >
> > When the moudle unload, the srcu_module_going() will call cleanup_srcu_=
struct()
> > and free_percpu(ssp->sda) to release resource. but we not call srcu_bar=
rier(),
> > the srcu_barrier() should be called before cleanup_srcu_struct().
> >
> >
> > > I know that srcu subsystem does a lot of magic with modules init/exit
> > > functionality to call init_srcu_struct() and cleanup_srcu_struct().
> > > See
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/kernel/module/main.c?h=3Dv7.3-rc1#n2711
> > >
> > > so this patch should be reverted. If they don't use a barrier there,
> > > the fix should be in the SRCU subsystem, but I believe the current
> > > SRCU implementation already handles this.
> >
> > The srcu_barrier() need to be called, there are some description
> > from Documentation/RCU/rcubarrier.rst:
> >
> > rcu_barrier()
> > -------------
> >
> > This situation can be handled by the rcu_barrier() primitive.  Rather
> > than waiting for a grace period to elapse, rcu_barrier() waits for all
> > outstanding RCU callbacks to complete.  Please note that rcu_barrier()
> > does **not** imply synchronize_rcu(), in particular, if there are no RC=
U
> > callbacks queued anywhere, rcu_barrier() is within its rights to return
> > immediately, without waiting for anything, let alone a grace period.
> >
> > Pseudo-code using rcu_barrier() is as follows:
> >
> >    1. Prevent any new RCU callbacks from being posted.
> >    2. Execute rcu_barrier().
> >    3. Allow the module to be unloaded.
> >
> > There is also an srcu_barrier() function for SRCU, and you of course
> > must match the flavor of srcu_barrier() with that of call_srcu().
> > If your module uses multiple srcu_struct structures, then it must also
> > use multiple invocations of srcu_barrier() when unloading that module.
> > For example, if it uses call_rcu(), call_srcu() on srcu_struct_1, and
> > call_srcu() on srcu_struct_2, then the following three lines of code
> > will be required when unloading::
> >
> >   1  rcu_barrier();
> >   2  srcu_barrier(&srcu_struct_1);
> >   3  srcu_barrier(&srcu_struct_2);
> > ....
>
> yes, I can see this makes problems when there is kmem_cache involved
> and you need to be sure it's being done before you destroy the
> kmem_cache.
>

okay, it can be the case for "nodes_srcu" but with the argumentation
it can release memory being used by kmem_cache that is being destroyed
later.

- Alex

