Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE821FE463;
	Wed,  8 Jan 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349842; cv=none; b=ZIxNItIWb17BMThasEl1S3ztpIPpcEgl8WvUMDxDsFANtSQFpjGKmIM71oEyyc8tOzo0gzIEdADBiyF/I5IIhFToi5H1kbzE+rsNbtU1/P+jdU90vvCXRiqyJ4USLKN386cMn42bpHhIKsPz3fW9s9lYZh0Pv5XsW6sOUTHyXj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349842; c=relaxed/simple;
	bh=OUomVLwXzAsHTN2OO2GN4tFSIGBqPtLRgBYcV0K2vgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gji/mSLJ1fvttxqKjfw6+Bfb8I30LGAqOf33dKkIkERZSWGZmF0bYZjATPSNogxibsuRMqk2isB0dp3PIM1jkrPuTAcEQeH39vsGgMJvme1qL8YJ87z6J5hf3fZA0OSvnYXr6N2Ra3rOsSxue3Rx9GOgIxuBpc1i1NqzVBcynII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZokAobQP; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZokAobQP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pR4pCSQ8JaNM+Z2KFvn7fIWTmWbNAoaYkSmwxCVVRPg=; b=ZokAobQPKEw4hncKJSme43+puh
	CQtqV6Nm5GqE9SuUrttFE3KZOKEXOO9oeT9ADJ7QlMecNG5AiQymPw3WhdxKiwvcmSBfxm96ua6LX
	+w93/wex2MMcCQuVMt2A3SQKccSL65tA7x0hzce6Fydhq92rqZRM7pgQ4IZK5to9DywCdpTNmUcEi
	9PmYPtVR+ALvWF1/zBnKS50BU0XldshZJYSGLrgMTRVqkA/hcP9+h8VkHowyWDQZ49julT1i4EYPy
	xALVRJrsUpXnaxuuaOqQj3UzaENasNc4JFyIzhEZSKh+gjqw0/TMX8iUfRTjqAbbgYRs6wRzZust/
	L1aoCzUw==;
Received: from 179-125-71-237-dinamico.pombonet.net.br ([179.125.71.237] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tVXuW-00DBEQ-9c; Wed, 08 Jan 2025 16:23:56 +0100
Date: Wed, 8 Jan 2025 12:23:48 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: gfs2@lists.linux.dev, David Teigland <teigland@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] dlm: prevent NPD when writing a positive value to
 event_done
Message-ID: <Z36YhIdSmkAP28jr@quatroqueijos.cascardo.eti.br>
References: <20241220141913.1346301-1-cascardo@igalia.com>
 <CAK-6q+hV41=KuZfFUpmJgm8YX8GVxoWZKiA_gGNHWXopt2VpBA@mail.gmail.com>
 <Z31wEtweV8FlQsVA@quatroqueijos.cascardo.eti.br>
 <CAK-6q+g3TYu5MKkwzcgDsBGjxZ3j5D-kxXdeFmQPv1dMxkSzRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK-6q+g3TYu5MKkwzcgDsBGjxZ3j5D-kxXdeFmQPv1dMxkSzRg@mail.gmail.com>

On Wed, Jan 08, 2025 at 09:27:31AM -0500, Alexander Aring wrote:
> Hi,
> 
> On Tue, Jan 7, 2025 at 1:19 PM Thadeu Lima de Souza Cascardo
> <cascardo@igalia.com> wrote:
> >
> > On Mon, Jan 06, 2025 at 11:14:35AM -0500, Alexander Aring wrote:
> > > Hi,
> > >
> > > On Fri, Dec 20, 2024 at 9:28 AM Thadeu Lima de Souza Cascardo
> > > <cascardo@igalia.com> wrote:
> > > >
> > > > do_uevent returns the value written to event_done. In case it is a positive
> > > > value, new_lockspace would undo all the work, and lockspace would not be
> > > > set. __dlm_new_lockspace, however, would treat that positive value as a
> > > > success due to commit 8511a2728ab8 ("dlm: fix use count with multiple
> > > > joins").
> > > >
> > > > Down the line, device_create_lockspace would pass that NULL lockspace to
> > > > dlm_find_lockspace_local, leading to a NULL pointer dereference:
> > > >
> > >
> > > This issue starts to be an issue since commit 4db41bf4f04f ("dlm:
> > > remove ls_local_handle from struct dlm_ls"). Before
> > > dlm_find_lockspace_local() was then returning NULL and
> > > device_create_lockspace() returned -ENOENT as it wasn't found a NULL
> > > lockspace handle, see [0].
> > > After the patch it dlm_find_lockspace_local() will end in a
> > > null-pointer dereference because we don't do this lookup of pointers
> > > when we already should have this pointer already.
> > > This behaviour is kind of weird (as it makes no sense to lookup NULL)
> > > and yes, I didn't see that when I wrote commit 4db41bf4f04f ("dlm:
> > > remove ls_local_handle from struct dlm_ls"). Just this commit signals
> > > us we do something stupid with the error handling.
> > >
> > > May I ask you which user space software do you use? As for
> > > dlm_controld I can't see that there is a positive number case for
> > > telling the event_done attribute. [1]
> >
> > I was just playing with it manually, that is, without dlm_controld. I was
> > writing down into configfs and sysfs manually while issuing ioctls and then
> > tripped over this NULL pointer dereference.
> >
> 
> ok, thanks... I am worried now you probably see more issues. :)
> 

I will try to send fixes if I find anything else.  ;-)

Thanks for the review.
Cascardo.

> > I see how commit 4db41bf4f04f ("dlm: remove ls_local_handle from struct
> > dlm_ls") leads to the NPD. In any case, I suppose the Fixes line could
> > either be the one I pointed to (since that is what leads to such positive
> > return values to undo lockspace creation and still be interpreted as
> > success) or 4db41bf4f04f, specially if we want to restrict the backports to
> > only the kernels with this latter commit.
> >
> 
> yes, it was already broken before. I agree.
> 
> Acked-by: Alexander Aring <aahringo@redhat.com>
> 
> - Alex
> 
> 
